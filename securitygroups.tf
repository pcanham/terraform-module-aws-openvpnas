resource "aws_security_group" "openvpn" {
  name        = "openvpn_sg"
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

// open vpn tcp - admin interface
resource "aws_security_group_rule" "allow_admin-ui_inbound_openvpn" {
  description = "Allow access to Admin UI"
  type        = "ingress"
  from_port   = 943
  to_port     = 943
  protocol    = "tcp"
  #tfsec:ignore:AWS006
  cidr_blocks       = [var.adminaccess_cidr]
  security_group_id = aws_security_group.openvpn.id
}
