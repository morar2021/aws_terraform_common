
data "aws_ami" "search" {
  count             = "${length(var.ami_search_name) > 0 ? 1 : 0}"
  
  most_recent       = true
  owners            = ["self"]

  filter {
    name            = "tag:Name"
    values          = ["${var.ami_search_name}"]
  }
}