output "sub_id" {
    value = "${aws_subnet.this.*.id}"
    description = "Subnet ID"
}

output "sub_arn" {
    value = "${aws_subnet.this.*.id}"
    description = "Subnet ARN"
}

output "subnet_name" {
    value = "${var.sub_name}"
    description = "Name and Tag Name for the Subnet"
}