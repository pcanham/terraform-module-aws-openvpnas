output "openvpnas_eip" {
  value = aws_eip.openvpn_ip.public_ip
}

output "openvpnas_user_secgrpid" {
  value = aws_security_group.openvpn_user.id
}

output "openvpnas_mgmt_secgrpid" {
  value = aws_security_group.openvpn_mgmt.id
}
