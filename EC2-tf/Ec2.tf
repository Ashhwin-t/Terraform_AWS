terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.69.1"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "example" {
  ami           = "ami-06259b63260eddc13"
  instance_type = "t3.micro"
  count         = 1
  #key_name     = "my-key-pair-tf"

  tags = {
    Name = "HelloWorld"
  }
}
