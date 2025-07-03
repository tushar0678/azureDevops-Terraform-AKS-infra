# --- Fetching Secrets from AWS Secrets Manager ---
data "aws_secretsmanager_secret_version" "backend_access" {
  secret_id = var.secret_id_for_backend
}

locals {
  backend_access_credentials = jsondecode(data.aws_secretsmanager_secret_version.backend_access.secret_string)
}

# Example usage:
# output "access_key" {
#   value = local.backend_access_credentials["access_key"]
#   sensitive = true
# }
