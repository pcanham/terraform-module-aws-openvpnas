resource "aws_ssm_parameter" "openvpnas_dns" {
  name        = "openvpnas_dns"
  description = "OpenVPN AS DNS Address"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = var.tags
}

resource "aws_ssm_parameter" "certificate_email" {
  name        = "certificate_email"
  description = "Email Address linked to letsencrypt certificate"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_realm" {
  name        = "openvpnas_ldap_realm"
  description = "LDAP realm for OpenVPN As for"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = local.common_tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_server" {
  name        = "openvpnas_ldap_server"
  description = "LDAP Server address for OpenVPN As"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_bind_dn" {
  name        = "openvpnas_ldap_bind_dn"
  description = "LDAP BIND DN for OpenVPN As"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_bind_pw" {
  name        = "openvpnas_ldap_bind_pw"
  description = "LDAP BIND Password for OpenVPN As"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_base_dn" {
  name        = "openvpnas_ldap_base_dn"
  description = "LDAP Base DN for Users"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_additional_params" {
  name        = "openvpnas_ldap_additional_params"
  description = "LDAP Additional parameters for OpenVPN As e.g. filter by memberof"
  type        = "SecureString"
  value       = var.atlantis_github_token
  overwrite   = true
  tags        = var.tags
}


# Apply our DSC via SSM
resource "aws_ssm_association" "openvpnas" {
  name             = "Unknown Method, ansible or shell script"
  association_name = "openvpnas"

  targets {
    key    = "InstanceIds"
    values = [aws_instance.openvpn[0].id]
  }
}
