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
    default ="Public"
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
variable "sub_azs" {
    description = "A list of AZs"
    type        = list(string)
    default = ["eu-west-2a"]
}
variable "user_data" {
}
variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}
variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(map(string))
  default     = []
}
variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}
variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}
variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = null
}
variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}
variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}