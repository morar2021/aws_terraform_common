output "ami_id" {
    value = "${element(data.aws_ami.search.*.id,0)}"
}