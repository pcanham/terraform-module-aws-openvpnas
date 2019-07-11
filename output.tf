output "openvpnas_eip" {
  value = aws_eip.openvpn_ip.*.public_ip
}

output "openvpnas_secgrpid" {
  value = aws_security_group.openvpn.*.id
}
