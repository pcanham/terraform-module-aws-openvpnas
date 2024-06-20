locals {
  suffix = coalesce(var.custom_suffix, random_id.suffix.id)
}
