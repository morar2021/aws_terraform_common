module "environment" {
  source                      = "../../aws/remotestate-map"
  subnet_search               = var.ec2_subnet_name
}
module "tag" {
  source                      = "../../aws/tags"
}
module "network_interface_security_group" {
  source                      = "../../network/security_group"
  secgrp_name                 = "test"
  secgrp_vpc_id               =  module.environment.vpc_id
  security_group_rules        = var.security_group_rules
}
module "ami_search" {
  source                      = "../../aws/ami"
  ami_search_name             = var.ami_search_name
}
resource "aws_network_interface" "network_interface" {
  subnet_id                   = tolist(module.environment.private_subnets)[0]
  security_groups             = [module.network_interface_security_group.secgrp_id]
}
resource "aws_network_interface_attachment" "network_interface_attachment" {
 instance_id                  = aws_instance.this.id
 network_interface_id         = aws_network_interface.network_interface.id
  device_index                = 0
}

resource "aws_instance" "this" {
  ami                         = module.ami_search.ami_id
  instance_type               = var.instance_type
  subnet_id                   = module.environment.private_subnets[0]
  tags                        = module.tag.all_tags

  network_interface {
    network_interface_id      = aws_network_interface.network_interface.id
    device_index              = 0
  }
}