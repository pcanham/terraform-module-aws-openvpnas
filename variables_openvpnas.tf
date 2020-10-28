variable "openvpnas_dns" {
  description = "FQDN of the openvpnas appliance"
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
