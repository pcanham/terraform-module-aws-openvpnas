## Variables
variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "environment_tag" {
  type        = string
  description = "Define the type of environment"
  default     = ""
}

variable "project_tag" {
  type        = string
  description = "Project code name or name"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID number, needed for implementing IAM permissions"
}

variable "route53_zone_name" {
  type        = string
  description = "Route 53 Zone name"
}

variable "subdomain_ttl" {
  type        = number
  description = "Route 53 TTL time"
  default     = "60"
}

variable "ssh_key" {
  type        = string
  description = "SSH Keyname for EC2 instance"
  default     = ""
}

variable "ami_id" {
  type        = string
  description = "The ID of the AMI to run otherwise will default to AWS AmazonLinux 2"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "default instance type of the openvpnas appliance."
  default     = "t3a.large"
}

variable "instance_disk_type" {
  type        = string
  description = "Data disk type defaults to \"gp2\" disk type"
  default     = "gp2"
  validation {
    condition     = contains(["gp3", "gp2", "io2", "io1", "standard"], lower(var.instance_disk_type))
    error_message = "EBS Volume type needs to be: \"gp3\", \"gp2\", \"io2\", \"io1\", \"standard\"."
  }
}

variable "instance_disk_encrypted" {
  type        = bool
  description = "Encrypt the EBS volumes"
  default     = true
}

variable "public_subnet_id" {
  type        = string
  description = "Pubic subnet ID where you wish to deploy the openvpnas appliance"
}

variable "ssh_port" {
  type        = number
  description = ""
  default     = 22
}

variable "adminaccess_cidr" {
  type        = list(any)
  description = ""
  default     = ["0.0.0.0/0"]
}

variable "clientaccess_cidr" {
  type        = list(any)
  description = ""
  default     = ["0.0.0.0/0"]
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 Bucket name where ansible scripts will be stored"
}

variable "ssm_playbook_location" {
  type        = string
  description = "Playbook directory location which is uploaded to S3"
  default     = ""
}
