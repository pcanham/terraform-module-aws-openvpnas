variable "openvpnas_dns" {
  description = "FQDN of the openvpnas appliance"
}
variable "admin_creation" {
  type        = bool
  description = "Do you wish to create a local admin account"
  default     = false
}
variable "admin_user" {
  type        = string
  description = "openvpnas local admin account name"
}
variable "admin_password" {
  type        = string
  description = "openvpnas local admin account password"
}
variable "configure_ldap" {
  type        = bool
  description = "Do you wish to enable LDAP configuration"
  default     = false
}
variable "ldap_realm" {
  description = "openvpnas ssh username for logging into the appliance"
  default     = "EXAMPLE"
}
variable "ldap_server" {
  description = "openvpnas ssh username for logging into the appliance"
  default     = "127.0.0.1"
}
variable "ldap_bind_dn" {
  description = "openvpnas ssh username for logging into the appliance"
  default     = "CN=svc_openvpnas,OU=Service Accounts,DC=ad,DC=example,DC=org"
}
variable "ldap_bind_pw" {
  description = "openvpnas ssh username for logging into the appliance"
}
variable "ldap_base_dn" {
  description = "openvpnas ssh username for logging into the appliance"
  default     = "OU=Regions,DC=ad,DC=example,DC=org"
}
variable "ldap_add_req" {
  description = "openvpnas ssh username for logging into the appliance"
  default     = "memberOf=CN=Dom VPN User,OU=Security Groups,DC=ad,DC=example,DC=org"
}
