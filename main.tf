terraform {
  backend "s3" {
    bucket = "foundry-virtual-tabletop"
    key = "terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
}
