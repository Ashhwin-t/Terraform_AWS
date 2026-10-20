terraform {
  backend "s3" {
    bucket  = "mylab-s3-bucket-demobucket"
    key     = "terraform-state/terraform.tfstate"
    region  = "ap-southeast-2"
    encrypt = true
  }
}