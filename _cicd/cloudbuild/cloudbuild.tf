resource "google_cloudbuild_trigge" "cloudbuild_trigger" {
  name        = var.trigger_name
  project     = var.gcp_project_id
  description = local.description
  disabled    = var.disabled
  tags        = var.tags

  git_file_source {
    path = var.cloudbuild_yaml_path
    uri  = var.github_source_url
    # revision  = "refs/heads/${var.trunk_branch_name}"  # Unspecified to use Triggered Branch
    repo_type = "GITHUB"
  }
  
  github {
    owner  = var.github_repo_owner
    name   = var.github_repo_name
    push {
      branch  = var.push_branch_name_regex
    }
  }

  ignored_files = [
    ".pytest_cache/**",
    ".hypothesis/**",
    "_cicd/*.tf",
    "_cicd/*.tfvars",
    ".github/**",
    "dist/**",
    "__pycache__/**",
    ".pyc",
  ]

  service_account = data.google_service_account.cloudbuild_service_account.id

  depends_on = [
    google_project_iam_member.act_as,
    google_project_iam_member.cloudbuild_service_agent,
    google_project_iam_member.gcs_object_viewer,
    google_project_iam_member.logs_writer,
  ]
}