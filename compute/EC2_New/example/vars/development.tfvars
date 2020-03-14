
ec2_instance_name       = "ec2_example"
instance_type           = "t2.small"
environment             = "development"
ec2_subnet_name         = "Private"
description             = "Example CentOS 7 EC2 Instance"
ec2_az                  = "eu-west-2a"
ami_name                = "CentOS-7-1805*"
vpc_security_group_ids = ["sg-006f1e09661fcba4f"]
secgrp_name = "example_sg"

security_group_rules    = [
{
    type            = "ingress"
    description     = "SSH Admin Access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_block     = "0.0.0.0/0"
},
{
    type            = "ingress"
    description     = "Cockpit port"
    from_port       = 9090
    to_port         = 9090
    protocol        = "tcp"
    cidr_block     = "0.0.0.0/0"
}
]