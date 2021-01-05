data "aws_route53_zone" "main" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "openvpn" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.openvpnas_dns
  type    = "A"
  ttl     = var.subdomain_ttl
  records = [aws_eip.openvpn_ip.public_ip]
}
