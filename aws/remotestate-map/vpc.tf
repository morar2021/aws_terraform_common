
# VPC
data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket                  = var.aws_bucket
        key                     = var.aws_key
        region                  = var.aws_region
    }
}
locals {
    vpc_public_subnet_map      = data.terraform_remote_state.vpc.outputs.public_subnets
    vpc_private_subnet_map     = data.terraform_remote_state.vpc.outputs.private_subnets
    public_subnets             = data.terraform_remote_state.vpc.outputs.public_subnets
    private_subnets            = data.terraform_remote_state.vpc.outputs.private_subnets
    vpc_id                     = data.terraform_remote_state.vpc.outputs.core_vpc_id
}