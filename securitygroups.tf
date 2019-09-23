resource "aws_security_group" "openvpn" {
  count       = var.create_openvpnas ? 1 : 0
  name        = "openvpn_sg"
  description = "Allow traffic needed by openvpn"
  vpc_id      = var.vpc_id
  tags        = var.tags

  // ssh
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  // https
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.https_cidr]
  }

  // open vpn udp
  ingress {
    from_port   = var.udp_port
    to_port     = var.udp_port
    protocol    = "udp"
    cidr_blocks = [var.udp_cidr]
  }

  // all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// open vpn tcp - admin interface
resource "aws_security_group_rule" "allow_admin-ui_inbound_openvpn" {
  count             = var.create_openvpnas ? 1 : 0
  type              = "ingress"
  from_port         = var.tcp_port
  to_port           = var.tcp_port
  protocol          = "tcp"
  cidr_blocks       = [var.tcp_cidr]
  security_group_id = aws_security_group.openvpn[0].id
}
