provider "heroku" {
  version = "~> 2.4"
}

variable "name" {
  description = "Name of the Terraform state store (Heroku app name)"
}

variable "team" {
  description = "Owner for the Terraform state store (Heroku Team)"
  default     = ""
}

variable "region" {
  description = "Region of the Terraform state store (Heroku app region)"
  default     = "us"
}

variable "postgresql_plan" {
  description = "Database plan of the Terraform state store (heroku-postgresql plan)"
  default     = "hobby-dev"
}

resource "heroku_app" "terraform_state" {
  name   = var.name
  region = var.region

  dynamic "organization" {
    for_each = var.team == "" ? [] : [var.team]
    content {
      name = organization.value
    }
  }
}

resource "heroku_addon" "database" {
  app  = heroku_app.terraform_state.id
  plan = "heroku-postgresql:${var.postgresql_plan}"
}

data "heroku_app" "terraform_state" {
  name = heroku_app.terraform_state.name
}

output "pg_connection_string" {
  sensitive = true
  value     = lookup(data.heroku_app.terraform_state.config_vars, "DATABASE_URL", "")
}

