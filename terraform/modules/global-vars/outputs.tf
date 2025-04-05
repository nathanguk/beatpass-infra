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
    Application = "beatpass"
    Environment = "Production"
    Criticality = "Tier 1"
    Owner       = "beatpass Admin"
    Deployed_By = "Terraform"
  }
}

output "current_user_id" {
  value = data.azuread_user.current_user.id
}

output "b2c_client_id" {
  value = "b6b1fbb1-e9e4-44a4-ab6c-d38f3b1b0526"
}

output "b2c_issuer" {
  value = "https://beatpass.b2clogin.com/4a4c6b40-3266-4194-a814-7a065cf4e414/v2.0/"
}

output "b2c_extensions_app_id" {
  value = "94a44b3e-9e52-426d-9902-2876c06e0748"
}