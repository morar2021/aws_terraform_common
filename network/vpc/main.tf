locals {
  max_subnet_length = max(
    length(var.vpc_secondary_sub_cidr),
  )

  # Use `local.vpc_id` to give a hint to Terraform that subnets should be deleted before secondary CIDR blocks can be free!
  vpc_id = element(
    concat(
      #aws_vpc_ipv4_cidr_block_association.this.*.vpc_id,
      aws_vpc.this.*.id,
      [""],
    ),
    0,
  )
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags                 = var.vpc_tags
}

module "primary_subnet" {
  source                        = "../subnet/"
  sub_vpc_id                    = aws_vpc.this.id
  sub_environment               = var.vpc_environment
  sub_cidr_block                = var.vpc_primary_sub_cidr
  sub_azs                       = var.vpc_primary_az
  sub_name                      = var.vpc_primary_subnet_name
  sub_public_ip_on_launch       = var.vpc_primary_public_ip_on_lauch
  subnets                       = var.vpc_primary_sub_cidr

  sub_tags = merge(
    {
      "Name" = var.vpc_primary_subnet_name
      "Tier" = "Primary"
    }
  )
}

module "secondary_subnet" {
  source                        = "../subnet/"
  sub_vpc_id                    = aws_vpc.this.id
  sub_environment               = var.vpc_environment
  sub_cidr_block                = var.vpc_secondary_sub_cidr
  sub_azs                       = var.vpc_secondary_az
  sub_name                      = var.vpc_secondary_subnet_name
  sub_public_ip_on_launch       = var.vpc_secondary_public_ip_on_lauch
  subnets                       = var.vpc_secondary_sub_cidr

  sub_tags = merge(
    {
      "Name" = var.vpc_secondary_subnet_name
      "Tier" = "Secondary"
    }
  )
}

###################
# Primary Routes
###################

resource "aws_route_table" "primary" {
  count = length(var.vpc_primary_sub_cidr) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      "Name" = format("%s-${var.vpc_primary_subnet_name}", var.vpc_name)
    },
    var.vpc_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count = length(var.vpc_primary_sub_cidr) > 0 ? 1 : 0

  route_table_id         = aws_route_table.primary[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

###################
# Secondary Routes
###################

resource "aws_route_table" "private" {
  count = local.max_subnet_length > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    var.vpc_tags
  )

  lifecycle {
    # When attaching VPN gateways it is common to define aws_vpn_gateway_route_propagation
    # resources that manipulate the attributes of the routing table (typically for the private subnets)
    ignore_changes = [propagating_vgws]
  }
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "this" {
  count = length(var.vpc_primary_sub_cidr) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    var.vpc_tags
  )
}

###################
# NAT Gateway
###################
#resource "aws_eip" "this" {
#  vpc  = "${aws_vpc.this.id}"
#  tags = "${var.vpc_tags}"
#}
#resource "aws_nat_gateway" "this" {
#  allocation_id = "${aws_eip.this.id}"
#  subnet_id     = "${var.nat_subnet}" #needs changing var.nat_subnet or a lookup
#  tags          = "${var.vpc_tags}"
#  depends_on = [
#    ["aws_eip.this"]
#  ]
#}
