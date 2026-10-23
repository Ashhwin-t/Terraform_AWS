# Look up networking in the current student's AWS account. This avoids
# hard-coding subnet and security-group IDs from the instructor's account.

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

locals {
  subnet_ids = sort(data.aws_subnets.default.ids)
}
