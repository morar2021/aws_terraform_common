
locals {
    all_tags = {
        "instance_name"             = "${var.ec2_instance_name}"
        "instance_environment"      = "${var.ec2_instance_environment}"
        "instance_schedule"         = "${var.ec2_instance_schedule}"
    }
}