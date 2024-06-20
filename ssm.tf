resource "aws_ssm_parameter" "openvpnas_dns" {
  name        = "openvpnas_dns"
  description = "OpenVPN AS DNS Address"
  type        = "SecureString"
  value       = var.openvpnas_dns
  tags        = var.tags
}

resource "aws_ssm_parameter" "certificate_email" {
  name        = "certificate_email"
  description = "Email Address linked to letsencrypt certificate"
  type        = "SecureString"
  value       = var.certificate_email
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_realm" {
  name        = "openvpnas_ldap_realm"
  description = "LDAP realm for OpenVPN As for"
  type        = "SecureString"
  value       = var.ldap_realm
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_server" {
  name        = "openvpnas_ldap_server"
  description = "LDAP Server address for OpenVPN As"
  type        = "SecureString"
  value       = var.ldap_server
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_bind_dn" {
  name        = "openvpnas_ldap_bind_dn"
  description = "LDAP BIND DN for OpenVPN As"
  type        = "SecureString"
  value       = var.ldap_bind_dn
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_bind_pw" {
  name        = "openvpnas_ldap_bind_pw"
  description = "LDAP BIND Password for OpenVPN As"
  type        = "SecureString"
  value       = var.ldap_bind_pw
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_base_dn" {
  name        = "openvpnas_ldap_base_dn"
  description = "LDAP Base DN for Users"
  type        = "SecureString"
  value       = var.ldap_base_dn
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_ldap_add_req" {
  name        = "openvpnas_ldap_additional_params"
  description = "LDAP Additional parameters for OpenVPN As e.g. filter by memberof"
  type        = "SecureString"
  value       = var.ldap_add_req
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_admin_user" {
  name        = "openvpnas_admin_user"
  description = "OpenVPN Admin User account name"
  type        = "SecureString"
  value       = var.admin_user
  tags        = var.tags
}

resource "aws_ssm_parameter" "openvpnas_admin_password" {
  name        = "openvpnas_admin_password"
  description = "OpenVPN Admin User password"
  type        = "SecureString"
  value       = var.admin_password
  tags        = var.tags
}

resource "aws_ssm_association" "openvpnas" {
  name             = "AWS-ApplyAnsiblePlaybooks"
  association_name = "openvpnas"
  parameters = {
    SourceType = "S3"
    SourceInfo = jsonencode({ "path" = lower(format("https://s3.amazonaws.com/%s/lab/",
      var.s3_bucket_name
    )) })
    PlaybookFile = "main.yml"
    ExtraVariables = format("enable_ldap_config=%s enable_letencrypt_config=%s create_admin_account=%s",
      (var.configure_letsencrypt ? "True" : "False"),
      (var.configure_ldap ? "True" : "False"),
      (var.admin_creation ? "True" : "False")
    )
    InstallDependencies = "True"
    Verbose             = "-v"
  }
  output_location {
    s3_bucket_name = aws_s3_bucket.ansible_bucket.id
    s3_key_prefix  = "logs/"
  }
  targets {
    key    = "InstanceIds"
    values = [aws_instance.openvpn.id]
  }
}
