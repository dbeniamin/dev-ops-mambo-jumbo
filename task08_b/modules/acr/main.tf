resource "azurerm_container_registry" "this" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_container_registry_task" "build_task" {
  name                  = "${var.acr_name}-build-task"
  container_registry_id = azurerm_container_registry.this.id
  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.context_path
    context_access_token = var.context_access_token
    image_names          = ["${var.image_name}:latest"]
  }

  agent_pool_name = null # Use default agent pool

  # Depends on the existence of the context (file in storage)
  depends_on = [var.build_task_depends_on]
}

resource "azurerm_container_registry_task_schedule_run_now" "build_now" {
  container_registry_task_id = azurerm_container_registry_task.build_task.id

  # This ensures the schedule runs when the task is created or updated
  depends_on = [azurerm_container_registry_task.build_task]
}