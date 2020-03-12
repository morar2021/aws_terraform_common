terraform {
  backend "s3" {
    bucket = "hothouse"
    key    = "proofofconcept/ec2_example/terraform.tfstate"
    region = "eu-west-2"
  }
}

