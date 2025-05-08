locals {
  # Resource names
  rg_name        = "${var.name_prefix}-rg"
  sa_name        = "${replace(var.name_prefix, "-", "")}sa"
  keyvault_name  = "${var.name_prefix}-kv"
  acr_name       = "${replace(var.name_prefix, "-", "")}cr"
  aks_name       = "${var.name_prefix}-aks"
  redis_aci_name = "${var.name_prefix}-redis-ci"
  aca_name       = "${var.name_prefix}-ca"
  aca_env_name   = "${var.name_prefix}-cae"

  # Other configuration values
  app_source_dir   = "${path.root}/application"
  app_archive_name = "app.tar.gz"
  image_name       = "${var.name_prefix}-app"

  # Common tags
  common_tags = {
    Creator = var.creator_tag
  }
}
