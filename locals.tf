locals {
  common_tags = {
    ENVIRONMENT = upper(var.environment_tag)
    OWNER       = upper(var.owner_tag)
    PROJECT     = upper(var.project_tag)
    COST-CENTER = upper(var.cost_center_tag)
    BUSINESS    = upper(var.business_tag)
    AUTOMATION  = var.automation_tag
  }
}
