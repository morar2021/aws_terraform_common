output "sub_id" {
    value = "${aws_subnet.this[count.index].id}"
    description = "Subnet ID"
}

output "sub_arn" {
    value = "${aws_subnet.*.id[count.index]}"
    description = "Subnet ARN"
}

output "subnet_name" {
    value = "${var.sub_name}"
    description = "Name and Tag Name for the Subnet"
}