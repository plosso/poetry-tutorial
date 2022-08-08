variable "gcp_region" {
  description = ""
  type = string
}

variable "gcp_project_id" {
  description = ""
    type = string
}

variable "cloudbuild_triggers" {
    type        = map(any)
    description = "Details for the triggers to be created"
}