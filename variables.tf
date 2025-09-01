variable "domain" {
  type        = string
  default     = "yenesewfreedom8gmail.onmicrosoft.com"
}

variable "user_display_name" {
  type        = string
  description = "Full name of the user"
}

variable "user_alias" {
  type        = string
  description = "Username before the @ (must be unique)"
}
variable "client_id" {
  type        = string
  description = "Azure App registration (client) ID"
}

variable "client_secret" {
  type        = string
  description = "Azure App registration client secret"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID of your Entra directory"
}

