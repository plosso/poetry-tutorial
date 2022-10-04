variable "gcp_project_id" {
  description = ""
    type      = string
}

variable "gcp_region" {
  description = ""
  type        = string
}

variable "gcp_account_id" {
  description = ""
  type        = string
}

variable "cloudbuild_triggers" {
    type        = any
    description = "Details for the triggers to be created"
}

## docker build automation
variable "repo_name" {
  default = "poetry-tutorial"
}
variable "build_deploy_filename" {
  default = "build-and-deploy.yaml"
}
variable "build_deploy_tag_filename" {
  default = "build-and-deploy-tag.yaml"
}
variable "build_filename" {
  default = "build.yaml"
}
variable "project_id" {
  default = "insuranceanalytics-dev"
}
variable "region" {
  default = "us-central1"
}
variable "sa_name" {
  default = "cloudbuild-support-portal"
}
variable "artifact_registry_project_id" {
  default = "engineering-artifacts-dev"
}
variable "artifact_registry_region" {
  default = "us-central1"
}