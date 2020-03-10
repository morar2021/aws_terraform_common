#Based on Hashicorp / Community EC2 Modules

module "environment" {
  source                      = "../../aws/remotestate-map"
  subnet_search               = var.ec2_subnet_name
}
module "tags" {
  source                      = "../../aws/tags"
}
#module "network_interface_security_group" {
#  source                      = "../../network/security_group"
#  secgrp_name                 = var.secgrp_name
#  secgrp_vpc_id               =  module.environment.vpc_id
#  security_group_rules        = var.security_group_rules
#k}
module "ami_search" {
  source                      = "../../aws/ami"
  ami_search_name             = var.ami_search_name
}

resource "aws_instance" "this" {
  count                       = var.instance_count
  ami                         = module.ami_search.ami_id
  instance_type               = var.instance_type
  user_data                   = var.user_data

  subnet_id = length(var.network_interface) > 0 ? null : element(module.environment.private_subnets, count.index)

  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  private_ip                  = length(var.private_ips) > 0 ? element(var.private_ips, count.index) : var.private_ip

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
    }
  }

  source_dest_check                    = length(var.network_interface) > 0 ? null : var.source_dest_check

  tags = merge(
    {
      "Name" = var.instance_count > 1 || var.use_num_suffix ? format("%s-%d", var.ec2_instance_name, count.index + 1) : var.ec2_instance_name
    },
    #var.ec2_tags,
  )

  volume_tags = merge(
    {
      "Name" = var.instance_count > 1 || var.use_num_suffix ? format("%s-%d", var.ec2_instance_name, count.index + 1) : var.ec2_instance_name
    },
    #var.volume_tags,
  )
}