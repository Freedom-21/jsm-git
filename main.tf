terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.50.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

provider "azuread" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

locals {
  formatted_display_name = "${title(var.first_name)} ${title(var.sur_name)}"
  base_alias = "${lower(var.first_name)}.${lower(var.sur_name)}"
}

data "azuread_user" "manager" {
  user_principal_name = var.manager_upn
}


resource "random_password" "initial" {
  length           = 16
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "azuread_user" "simple_user" {
  display_name          = local.formatted_display_name
  mail_nickname         = local.base_alias
  user_principal_name   = "${self.mail_nickname}@${var.domain}"
  password              = random_password.initial.result
  force_password_change = true
  account_enabled       = true
  manager_id = data.azuread_user.manager.object_id
}

output "new_user_upn" {
  value = azuread_user.simple_user.user_principal_name
}

output "temporary_password" {
  value     = random_password.initial.result
  sensitive = true
}
