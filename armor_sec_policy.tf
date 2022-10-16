resource "google_compute_security_policy" "policy" {
  for_each = { for iter in var.armor_sec_policy : iter.policy_name => iter }
  name     = each.key
  project  = each.value["project"]

  dynamic "rule" {
    for_each = each.value["rule"]
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        versioned_expr = rule.value.versioned_expr
        config {
          src_ip_ranges = rule.value.src_ip_range
        }
      }
      description = rule.value.description
    }
  }
}
