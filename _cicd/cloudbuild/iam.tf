data "google_service_account" "cloudbuild_service_account" {
  account_id = "cloudbuild-user-test"
  project    = var.gcp_project_id
}

resource "google_project_iam_member" "act_as" {
  project = var.gcp_project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_service_account.email}"
}

resource "google_project_iam_member" "cloudbuild_service_agent" {
  project = var.gcp_project_id
  role    = "roles/cloudbuild.serviceAgent"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_service_account.email}"
}

resource "google_project_iam_member" "logs_writer" {
  project = var.gcp_project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_service_account.email}"
}

resource "google_project_iam_member" "gcs_object_viewer" {
  project = var.gcp_project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_service_account.email}"
}

resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.artifact_registry_gcp_project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_service_account.email}"
}

resource "google_project_iam_member" "secret_manager_accessor" {
  project = var.artifact_registry_gcp_project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${data.google_service_account.cloudbuild_service_account.email}"
}