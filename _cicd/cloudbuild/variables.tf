variable "trigger_name" {
  description = ""
  type        = string
}

variable "disabled" {
  description = ""
  type        = bool
}

variable "github_source_url" {
  description = ""
  type        = string
}

variable "trunk_branch_name" {
  description = ""
  type        = string
}

variable "github_repo_owner" {
  description = ""
  type        = string
}

variable "github_repo_name" {
  description = ""
  type        = string
}

variable "push_branch_name_regex" {
  description = ""
  type        = string
}

variable "cloudbuild_yaml_path" {
  description = ""
  type        = string
}

variable "tags" {
  description = ""
  type        = list(any)

}

variable "gcp_project_id" {
  description = ""
  type        = string
}

variable "artifact_registry_gcp_project_id" {
  description = ""
  type        = string
}

variable "custom_description" {
  description = ""
  type        = string
}

locals {
  description = "custom cloud build: ${var.custom_description}"
}