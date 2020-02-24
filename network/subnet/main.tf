locals {
  tags = "${map(
    "Name", "${var.sub_name}",
    "environent","${var.sub_environment}"
  )}"
}

resource "aws_subnet" "this" {
  vpc_id                        = "${var.sub_vpc_id}"
  cidr_block                    = "${var.sub_cidr_block}"
  map_public_ip_on_launch       = "${var.sub_public_ip_on_launch}"

  
  tags = "${merge(
      local.tags,"${var.sub_tags}"
  )}"
}