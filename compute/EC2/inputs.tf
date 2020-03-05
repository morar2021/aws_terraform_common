variable "ec2_instance_name" {
    default = "ec2_instance_default"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "ec2_instance_environment" {
    default = "Development"
}
variable "ec2_instance_schedule" {
    default = "always_on"
}
variable "ec2_subnet_name" {
    default ="Front End"
}
variable "description" {
    default = "EC2 Instance"
}
variable "ami_search_name" {
  default = ""
}
variable "security_group_rules" {
    default = []
  
}