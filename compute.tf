data "aws_ami" "openvpn" {
  count       = var.create_openvpnas ? 1 : 0
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server 2.7*"]
  }
}

resource "aws_key_pair" "openvpn" {
  count      = var.create_openvpnas ? 1 : 0
  key_name   = "openvpn-key"
  public_key = var.public_key
}

resource "aws_instance" "openvpn" {
  count = var.create_openvpnas ? 1 : 0
  tags = {
    Name = "openvpn"
  }

  ami                         = var.ami == "" ? data.aws_ami.openvpn[0].image_id : var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.openvpn[0].key_name
  subnet_id                   = var.public_subnet_id[0]
  vpc_security_group_ids      = [aws_security_group.openvpn[0].id]
  iam_instance_profile        = aws_iam_instance_profile.openvpn[0].name
  associate_public_ip_address = true
  source_dest_check           = false

  # `admin_user` and `admin_pw` need to be passed in to the appliance through `user_data`, see docs -->
  # https://docs.openvpn.net/how-to-tutorialsguides/virtual-platforms/amazon-ec2-appliance-ami-quick-start-guide/
  user_data = <<USERDATA
admin_user=${var.admin_user}
admin_pw=${var.admin_password}
USERDATA
}

resource "aws_eip" "openvpn_ip" {
  count = var.create_openvpnas ? 1 : 0
  vpc = true
  instance = aws_instance.openvpn[0].id

  tags = merge(
    local.common_tags,
    { "Name" = lower(
      format(
        "openvpn-eip-%s-%s",
        var.project_tag,
        var.environment_tag,
      ),
      )
    }
  )
}

resource "null_resource" "provision_openvpn" {
  count = var.create_openvpnas ? 1 : 0
  triggers = {
    subdomain_id = aws_route53_record.openvpn[0].id
  }

  connection {
    type = "ssh"
    host = aws_eip.openvpn_ip[0].public_ip
    user = var.ssh_user
    port = var.ssh_port
    private_key = var.private_key
    agent = false
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 60",
      "sudo systemctl disable apt-daily.service",
      "sudo systemctl disable apt-daily.timer",
      "ps aux | grep /var/lib/dpkg/lock | awk {'print $2'} | sudo xargs kill -9",
      "sudo lsof | grep /var/lib/dpkg/lock | awk {'print $2'} | sudo xargs kill -9",
      "sudo lsof | grep /usr/bin/dpkg | awk {'print $2'} | sudo xargs kill -9",
      "sudo rm -f /var/lib/dpkg/lock",
      "ps aux | grep /var/cache/apt/archives/lock | awk {'print $2'} | sudo xargs kill -9",
      "ps aux | grep apt | awk {'print $2'} | xargs sudo kill -9",
      "ps aux | grep /var/cache/apt/archives/lock | awk {'print $2'} | sudo xargs kill -9",
      "sudo lsof | grep /var/cache/apt/archives/lock | awk {'print $2'} | sudo xargs kill -9",
      "sudo rm -f /var/cache/apt/archives/lock",
      "sudo dpkg — configure -a",
      "sudo apt-get install -y software-properties-common unattended-upgrades",
      "sudo add-apt-repository -y ppa:certbot/certbot",
      "sudo apt-get -y update",
      "sudo apt-get -y install certbot python3-certbot-dns-route53",
      "sudo service openvpnas stop",
      "sudo certbot certonly --dns-route53 --non-interactive --agree-tos --email ${var.certificate_email} -d ${var.subdomain_name} --pre-hook 'service openvpnas stop' --post-hook 'service openvpnas start'",
      "sudo ln -s -f /etc/letsencrypt/live/${var.subdomain_name}/cert.pem /usr/local/openvpn_as/etc/web-ssl/server.crt",
      "sudo ln -s -f /etc/letsencrypt/live/${var.subdomain_name}/privkey.pem /usr/local/openvpn_as/etc/web-ssl/server.key",
      "sudo ln -s -f /etc/letsencrypt/live/${var.subdomain_name}/chain.pem /usr/local/openvpn_as/etc/web-ssl/ca.crt",
      "sudo service openvpnas start",
      "sudo /usr/local/openvpn_as/scripts/sacli --key vpn.client.tls_version_min --value 1.2 ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key vpn.client.tls_version_min_strict --value true ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key vpn.server.tls_version_min --value 1.2 ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key cs.tls_version_min --value 1.2 ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key cs.tls_version_min_strict --value true ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key vpn.client.config_text --value 'cipher AES-256-CBC' ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key vpn.server.config_text --value 'cipher AES-256-CBC' ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli --key 'cs.openssl_ciphersuites' --value 'EECDH+CHACHA20:EECDH+AES128:EECDH+AES256:!RSA:!3DES:!MD5' ConfigPut",
      "sudo /usr/local/openvpn_as/scripts/sacli -u ${var.openvpn_user} -k type -v user_connect UserPropPut",
      "sudo /usr/local/openvpn_as/scripts/sacli -u ${var.openvpn_user} --new_pass '${var.openvpn_password}' SetLocalPassword",
      "sudo service openvpnas stop",
      "sudo service openvpnas start"
    ]
  }
}
