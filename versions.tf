terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.32.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.7.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }
}
