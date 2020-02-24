variable "secgrp_name_prefix" {
    default = "default_secgrp_name_prefix"
}
variable "secgrp_description" {
    default = "default_secgrp_description"
}
variable "secgrp_name" {
    default = "default_secgrp_name"
}
variable "secgrp_ingress" {
    default = "default_secgrp_ingress"
}
variable "secgrp_egress" {
    default = "default_secgrp_egress"
}
variable "secgrp_vpc_id" {
    default = "default"
}
variable "secgrp_revoke_rules_on_delete" {
    default = "default_secgrp_revoke_rules_on_delete"
}
variable "secgrp_environment" {
    default = "production"
}

variable "security_group_rules" {
    default = []
}