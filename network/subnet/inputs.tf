variable "sub_cidr_block" {
    description = "Subnet CIDR block"
    default = "0.0.0.0/16"
}
variable "sub_public_ip_on_launch" {
    default = "false"
    description = "Public IP address on launch, by deafult for EC2 instances"
}
variable "sub_vpc_id" {
    description = "VPC ID of the associated subnet"
}
variable "sub_environment" {
    description = "Environment tag"
    default = "development"
}
variable "sub_name" {
    description = "Subnet name"
    default = "Subnet"
}
variable "sub_tags" {
    type = "map"
    default = {}
}
variable "sub_azs" {
    description = "A list of AZs"
    type        = list(string)
    default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}
variable "subnets" {
    description = "A list of subnets"
    type        = list(string)
    default     = []
}