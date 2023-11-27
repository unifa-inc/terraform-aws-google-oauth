variable prefix {
  default = "cognite"
}

variable tags {
  default = {}
}

variable callback_domain_base {}

variable google_client_id {}
variable google_client_secret {}


variable listener_arn {}
variable target_group_arn {}
variable listener_rule_priority {
  default = 1
}
