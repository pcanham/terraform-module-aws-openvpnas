terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.50.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.3.0"
    }
  }
}
