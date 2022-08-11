terraform {
  # backend "local" {
  #   path = "./tfstate-backend/terraform.tfstate"
  # }
  backend "gcs" {
    bucket = "cloudbuild-testing"
    prefix = "terraform-state/github/plosso/poetry/_cicd"
  }
}
