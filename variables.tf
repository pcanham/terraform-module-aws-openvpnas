## Variables
variable "create_openvpnas" {
  description = "Boolean create openvpnas true or false"
}

variable "environment_tag" {
  description = "Define the type of environment"
  default     = ""
}

variable "owner_tag" {
  description = "Identifies the role that is responsible for the service"
  default     = ""
}

variable "project_tag" {
  description = "Project code name or name"
  default     = ""
}

variable "cost_center_tag" {
  description = "Budget code for responsible for the service"
  default     = ""
}

variable "business_tag" {
  description = "Business Stream that requires instance(s) e.g. Infrastructure, Legal, etc"
  default     = ""
}

variable "automation_tag" {
  description = "Tag to highlight services/components have been created with an automation tool"
  default     = "Created with Terraform"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "public_key" {
  description = "public ssh key for logging into the EC2 instance"
}

variable "private_key" {
  description = "private ssh key for logging into the EC2 instance"
}

variable "route53_zone_name" {
  description = "Route 53 Zone name"
}

variable "subdomain_name" {
  description = "FQDN of the openvpnas appliance"
}

variable "subdomain_ttl" {
  description = "Route 53 TTL time"
  default     = "60"
}

variable "ami" {
  description = "AMI ID of the openvpnas appliance, will be different in each region"
}

variable "instance_type" {
  description = "default instance type of the openvpnas appliance."
  default     = "t3.large"
}

variable "public_subnet_id" {
  description = "Pubic subnet ID where you wish to deploy the openvpnas appliance"
}

variable "admin_user" {
  description = "Admin username for the openvpnas appliance"
}

variable "admin_password" {
  description = "Admin password for the openvpnas appliance"
}

variable "openvpn_user" {
  description = "General user account username for the openvpnas appliance for being able to VPN into the VPC"
}

variable "openvpn_password" {
  description = "General user account password for the openvpnas appliance for being able to VPN into the VPC"
}

variable "certificate_email" {
  description = "email address to link the letsencrypt SSL certificate"
}

variable "ssh_user" {
  description = "openvpnas ssh username for logging into the appliance"
  default     = "openvpnas"
}

variable "ssh_port" {
  default = 22
}

variable "ssh_cidr" {
  default = "0.0.0.0/0"
}

variable "https_port" {
  default = 443
}

variable "https_cidr" {
  default = "0.0.0.0/0"
}

variable "tcp_port" {
  default = 943
}

variable "tcp_cidr" {
  default = "0.0.0.0/0"
}

variable "udp_port" {
  default = 1194
}

variable "udp_cidr" {
  default = "0.0.0.0/0"
}
