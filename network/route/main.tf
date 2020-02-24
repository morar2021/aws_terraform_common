resource "aws_rote_table" "this" {
  name        = "${var.rttbl_name}"
  description = "${var.rttbl_description}"
  vpc_id      = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.rttbl_name}"
    Environment = "${var.rttbl_environment}"
  }
}