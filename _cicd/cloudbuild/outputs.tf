output "cloudbuild_trigger_id" {
    value = google_cloudbuild_trigger.cloudbuild_trigger.id
    description = ""
}

output "cloudbuild_service_account_email" {
    value = data.google_service_account.cloudbuild_service_account.email
    description = ""
}