variable "vpc_name" {
    default = "default_vpc_name"
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "vpc_environment" {
    default = "production"
}
variable "vpc_instance_tenancy" {
    default = ""
}
variable "vpc_enable_dns_hostnames" {
    default = true
}
variable "vpc_enable_dns_support" {
    default = true
}
variable "vpc_primary_cidr" {
    default = "10.60.0.0/24"
}
variable "vpc_secondary_cidr" {
    default = "10.61.0.0/24"
}
variable "vpc_primary_az" {
    default = "euw2-az1"
}
variable "vpc_secondary_az" {
    default = "euw2-az2"
}
variable "vpc_tags" {
    type = "map"
    default = {}
}
variable "vpc_primary_subnet_name" {
    default = "VPC Primary Subnet"
}
variable "vpc_secondary_subnet_name" {
    default = "VPC Secondary Subnet"
}
variable "vpc_secondary_public_ip_on_lauch" {
    default = "false"
}
variable "vpc_primary_public_ip_on_lauch" {
    default = "false"
}