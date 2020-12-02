data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
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
  volume_tags = var.tags
  root_block_device {
    volume_type = "gp2"
    encrypted   = true
  }
  ami                    = var.ami_id == "" ? data.aws_ami.openvpn.image_id : var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key == "" ? null : var.ssh_key
  subnet_id              = var.public_subnet_id[0]
  vpc_security_group_ids = [aws_security_group.openvpn.id]
  iam_instance_profile   = aws_iam_instance_profile.openvpn.name
  #tfsec:ignore:AWS012
  associate_public_ip_address = true
  source_dest_check           = false
}

resource "aws_eip" "openvpn_ip" {
  vpc      = true
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
