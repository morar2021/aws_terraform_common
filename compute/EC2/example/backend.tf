terraform {
  backend "s3" {
    bucket = "bamaluztfstate"
    key    = "production/ec2_example/terraform.tfstate"
    region = "eu-west-2"
  }
}

