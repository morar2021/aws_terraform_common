
resource "aws_security_group" "this" {
  name                        = "${var.secgrp_name}"
  description                 = "${var.secgrp_description}"
  vpc_id                      = "${var.secgrp_vpc_id}"
}

resource "aws_security_group_rule" "this" {
  count                       = "${length(var.security_group_rules)}"
  security_group_id           = "${aws_security_group.this.id}"
  type                        = "${lookup(var.security_group_rules[count.index], "type")}"
  description                 = "${lookup(var.security_group_rules[count.index], "description")}"
  from_port                   = "${lookup(var.security_group_rules[count.index], "from_port")}"
  to_port                     = "${lookup(var.security_group_rules[count.index], "to_port")}"
  protocol                    = "${lookup(var.security_group_rules[count.index], "protocol")}"
  cidr_blocks                 = "${split(",",lookup(var.security_group_rules[count.index], "cidr_block"))}"
}