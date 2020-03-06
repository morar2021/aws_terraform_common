provider "aws" {
  region = "eu-west-2"
}

module "ec2_instance" {
  source = "../"
  
  instance_count = 1
  name          = var.ec2_instance_name
  ami           = var.ami_name
  instance_type = var.instance_type
  associate_public_ip_address = false

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp2"
      volume_size = 5
    }
  ]

user_data          = <<EOF
#!/bin/bash
yum -y update
echo "Hello World"
EOF

  tags = {
    "Env"      = "Private"
    "Location" = "Secret"
  }
}

module "ec2_with_network_interface" {
  source = "../"

  instance_count = 1

  name            = "example-network"
  ami             = var.ami_name
  instance_type   = "t2.medium"

  network_interface = [
    {
      device_index          = 0
      network_interface_id  = aws_network_interface.this[0].id
      delete_on_termination = false
    }
  ]
}