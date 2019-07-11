data "aws_route53_zone" "main" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "openvpn" {
  count   = var.create_openvpnas ? 1 : 0
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.subdomain_name
  type    = "A"
  ttl     = var.subdomain_ttl
  records = [aws_eip.openvpn_ip[0].public_ip]
}
