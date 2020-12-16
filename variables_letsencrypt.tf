variable "configure_letsencrypt" {
  type        = bool
  description = "Do you wish to enable Letsencrupt"
  default     = false
}
variable "certificate_email" {
  description = "email address to link the letsencrypt SSL certificate"
}
