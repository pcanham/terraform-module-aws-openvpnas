data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server 2.8.5*"]
  }
}

resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn-key"
  public_key = var.public_key
}

resource "aws_instance" "openvpn" {
  tags = merge(
    var.tags,
    { "Name" = lower(
      format(
        "openvpn-%s-%s",
        var.project_tag,
        var.environment_tag,
      ),
      )
    }
  )

  ami                         = var.ami == "" ? data.aws_ami.openvpn.image_id : var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.openvpn.key_name
  subnet_id                   = var.public_subnet_id[0]
  vpc_security_group_ids      = [aws_security_group.openvpn.id]
  iam_instance_profile        = aws_iam_instance_profile.openvpn.name
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
  vpc = true
  instance = aws_instance.openvpn.id

  tags = merge(
    var.tags,
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
  triggers = {
    subdomain_id = aws_route53_record.openvpn.id
  }

  connection {
    type = "ssh"
    host = aws_eip.openvpn_ip.public_ip
    user = var.ssh_user
    port = var.ssh_port
    private_key = var.private_key
    agent = false
  }

  data "template_file" "openvpnas" {
    template = file("./templates/openvpnas_init.sh.tpl")
    vars = {
      certificate_email = "jbloggs@example.com"
      subdomain_name = "vpn.example.com"
      openvpn_user = "ovpnadmin"
      openvpn_password = "FrogsAreUltraSecureMe!"
      ldap_enabled = true
      ldap_name = "127.0.0.1"
      ldap_server = "EXAMPLE"
      ldap_bind_dn = "CN=svc_openvpn,OU=Service Accounts,OU=Non-Geographic,OU=Regional Infrastructure Depts,DC=example,DC=local"
      ldap_password = "CatsAreUltraSecureMe!"
      ldap_base_dn = "OU=Regions,DC=example,DC=local"
      ldap_memberof_filter = "memberOf=CN=Dom VPN User,OU=Security Groups,OU=Non-Geographic,OU=Regional Infrastructure Depts,DC=example,DC=local"
    }
  }

  provisioner "remote-exec" {
    inline = <<EOF
${template_file.openvpnas.rendered}
EOF
  }
}
