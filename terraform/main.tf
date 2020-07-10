provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "tech-insiders-tdi"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
