resource "aws_security_group" "openvpn_user" {
  name        = "openvpn_user"
  description = "Allow traffic needed by openvpn"
  vpc_id      = var.vpc_id
  tags        = var.tags

  // https
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    #tfsec:ignore:AWS008
    cidr_blocks = [var.clientaccess_cidr]
  }

  // open vpn udp
  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    #tfsec:ignore:AWS008
    cidr_blocks = [var.clientaccess_cidr]
  }

  // all outbound traffic
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "openvpn_mgmt" {
  name        = "openvpn_mgmt"
  description = "Allow traffic needed by openvpn"
  vpc_id      = var.vpc_id
  tags        = var.tags

  // https
  ingress {
    from_port = 943
    to_port   = 943
    protocol  = "tcp"
    #tfsec:ignore:AWS008
    cidr_blocks = [var.adminaccess_cidr]
  }

  // open vpn udp
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    #tfsec:ignore:AWS008
    cidr_blocks = [var.adminaccess_cidr]
  }

  // all outbound traffic
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #tfsec:ignore:AWS009
    cidr_blocks = ["0.0.0.0/0"]
  }
}
