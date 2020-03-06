output "vpc_arn" {
    description = "The VPC arn"
    value = "${aws_vpc.this.arn}"
}
output "vpc_cidr-block" {
    description = "The VPC CIDR block"
    value = "${aws_vpc.this.cidr_block}"
}
output "vpc_instance-tenancy" {
    description = "The VPC tenancy"
    value = "${aws_vpc.this.instance_tenancy}"
}
output "vpc_dns-support" {
    description = "Whether or not The VPC has DNS hostname support"
    value = "${aws_vpc.this.enable_dns_support}"
}
output "vpc_dns-hostnames" {
    description = "Whether or not the VPC has hostname support"
    value = "${aws_vpc.this.enable_dns_hostnames}"
}

output "vpc_route-table" {
    description = "The ID of the main route table associated with the VPC"
    value = "${aws_vpc.this.main_route_table_id}"
}
output "vpc_default-net-acl" {
    description = "The ID of the network ACL create by default"
    value = "${aws_vpc.this.default_network_acl_id}"
}
output "vpc_default-sec-group" {
    description = "The ID of the security group created by default"
    value = "${aws_vpc.this.default_security_group_id}"
}
output "vpc_default-route-tbl" {
    description = "The ID of the route table created by default"
    value = "${aws_vpc.this.default_route_table_id}"
}
output "vpc_ipv6-association" {
    description = "The ID of ipv6 associated created by default"
    value = "${aws_vpc.this.ipv6_association_id}"
}
output "vpc_ipv6-cidr-block" {
    description = "The ID of the CIDR block created by default"
    value = "${aws_vpc.this.ipv6_cidr_block}"
}
output "vpc_owner-id" {
    description = "VPC owner ID"
    value = "${aws_vpc.this.owner_id}"
}
output "primary_subnet_map" {
    value = "${module.primary_subnet.sub_id}"
}
output "secondary_subnet_map" {
    value = "${module.secondary_subnet.sub_id}"
}

output "vpc_id" {
    value = "${aws_vpc.this.id}"
}