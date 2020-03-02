locals {
  tags = "${map(
    "Name", "${var.sub_name}",
    "environent","${var.sub_environment}"
  )}"
}

resource "aws_subnet" "this" {

  count = length(var.sub_azs)

  availability_zone               = length(regexall("^[a-z]{2}-", element(var.sub_azs, count.index))) > 0 ? element(var.sub_azs, count.index) : null
  availability_zone_id            = length(regexall("^[a-z]{2}-", element(var.sub_azs, count.index))) == 0 ? element(var.sub_azs, count.index) : null

  vpc_id                          = "${var.sub_vpc_id}"
  cidr_block                      = element(concat(var.subnets, [""]), count.index)
  map_public_ip_on_launch         = "${var.sub_public_ip_on_launch}"

  
  tags = "${merge(
      local.tags,"${var.sub_tags}"
  )}"
}