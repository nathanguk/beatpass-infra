#Outputs

output "tenant_id" {
  value = "6781348b-58d8-4ec2-89b8-fde80f099350"
  sensitive = true
}

output "subscription_id" {
    value = "26c42b58-838c-4899-b113-0245b2812864"
    sensitive = true
}

output "location" {
    value = "uksouth"
}

output "resource_name_prefix" {
    value = "beatpass"
}

output "tags" {
  value = {
    Application = "BeatPass"
    Environment = "Production"
    Criticality = "Tier 1"
    Owner       = "BeatPass Admin"
    Deployed_By = "Terraform"
  }
}

output "current_user_id" {
  value = data.azuread_user.current_user.id
}