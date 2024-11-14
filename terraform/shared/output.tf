#Outputs

output "application_insights_key_shared" {
  value = module.app_insights_shared.application_insights_key
  sensitive = true
}