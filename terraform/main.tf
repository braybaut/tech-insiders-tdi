terraform {
  required_version = "0.12.24"

  backend "s3" {
    bucket = "tech-insiders-tdi"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}
