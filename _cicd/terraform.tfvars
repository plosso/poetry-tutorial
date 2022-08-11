gcp_project_id = "devops-poc-328820"
gcp_region     = "us-east1"
gcp_account_id = "tf-sa-test"

cloudbuild_triggers = {
  "unit-test" = {
    trigger_name                     = "patrick-losso-overjet-unit-test"
    disabled                         = false
    github_source_url                = "https://github.com/patrick-losso-overjet/poetry-tutorial"
    github_repo_owner                = "patrick-losso-overjet"
    github_repo_name                 = "poetry-tutorial"
    push_branch_name_regex           = "main"
    release_tag                      = null
    artifact_registry_gcp_project_id = "devops-poc-328820"
    custom_description               = "Cloudbuild unit test trigger"
    cloudbuild_yaml_path             = "_cicd/pytest_cloudbuild.yaml"
    tags                             = ["python", "unit-tests"]
  },
  "build-wheel-pkg" = {
    trigger_name                     = "patrick-losso-overjet-build-wheel-pkg"
    disabled                         = false
    github_source_url                = "https://github.com/patrick-losso-overjet/poetry-tutorial"
    github_repo_owner                = "patrick-losso-overjet"
    github_repo_name                 = "poetry-tutorial"
    push_branch_name_regex           = null
    release_tag                      = ".*"
    artifact_registry_gcp_project_id = "devops-poc-328820"
    custom_description               = "Cloudbuild run for building Python wheel trigger"
    cloudbuild_yaml_path             = "_cicd/build_wheel.yaml"
    tags                             = ["python"]
  }
}
