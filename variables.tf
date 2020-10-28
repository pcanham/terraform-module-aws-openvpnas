## Variables
variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "environment_tag" {
  description = "Define the type of environment"
  default     = ""
}

variable "project_tag" {
  description = "Project code name or name"
  default     = ""
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

variable "ssh_user" {
  description = "openvpnas ssh username for logging into the appliance"
  default     = "openvpnas"
}

variable "ssh_port" {
  description = ""
  default     = 22
}

variable "adminaccess_cidr" {
  description = ""
  default     = "0.0.0.0/0"
}

variable "clientaccess_cidr" {
  description = ""
  default     = "0.0.0.0/0"
}

variable "s3_bucket_name" {
  description = "S3 Bucket name where ansible scripts will be stored"
}
