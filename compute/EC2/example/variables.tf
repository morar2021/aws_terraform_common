variable "ec2_instance_name" {
    default = "Default EC2 Instance"
}

variable "instance_type" {
    default = "t2.mirco"
}

variable "environment" {
    default = "Development"
}

variable "ec2_subnet_name" {
    default = "Private"
}

variable "description" {
    default = "Deafault EC2 Insatnce"
}

variable "ami_name" {
    default = ""
}

variable "security_group_rules" {
    default = []
}
variable "user_data" {
    default = ""
}


