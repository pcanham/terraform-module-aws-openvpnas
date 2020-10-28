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

  ami                    = var.ami == "" ? data.aws_ami.openvpn.image_id : var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.openvpn.key_name
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
