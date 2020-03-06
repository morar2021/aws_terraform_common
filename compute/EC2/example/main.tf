provider "aws" {
  region = "eu-west-2"
}

module "ec2_instance" {
  source = "../"


  instance_count = 1

  name          = "example-normal"
  ami           = var.ami_name
  instance_type = "c5.large"
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]

  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  placement_group             = aws_placement_group.web.id

  user_data_base64 = base64encode(local.user_data)

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
      encrypted   = true
      kms_key_id  = aws_kms_key.this.arn
    }
  ]

  tags = {
    "Env"      = "Private"
    "Location" = "Secret"
  }
}

module "ec2_with_network_interface" {
  source = "../"

  instance_count = 1

  name            = "example-network"
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = "c5.large"
  placement_group = aws_placement_group.web.id

  network_interface = [
    {
      device_index          = 0
      network_interface_id  = aws_network_interface.this[0].id
      delete_on_termination = false
    }
  ]
}