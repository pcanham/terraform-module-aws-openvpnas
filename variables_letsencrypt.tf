variable "configure_letsencrypt" {
  type        = bool
  description = "Do you wish to enable Letsencrupt"
  default     = false
}
variable "certificate_email" {
  type        = string
  description = "email address to link the letsencrypt SSL certificate"
}
