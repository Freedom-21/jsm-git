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
  # tenant_id     = var.tenant_id
}



resource "random_password" "initial" {
  length           = 16
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
}

resource "azuread_user" "simple_user" {
  display_name          = var.user_display_name
  user_principal_name   = "${var.user_alias}@${var.domain}"
  mail_nickname         = var.user_alias
  password              = random_password.initial.result
  force_password_change = true
  account_enabled       = true
}

output "new_user_upn" {
  value = azuread_user.simple_user.user_principal_name
}

output "temporary_password" {
  value     = random_password.initial.result
  sensitive = true
}
