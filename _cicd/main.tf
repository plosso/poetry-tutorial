# module "cloudbuild_triggers" {
#   source    = "./cloudbuild"
#   for_each  = var.cloudbuild_triggers

#   gcp_project_id                    = var.gcp_project_id
  
#   github_repo_owner                 = each.value.github_repo_owner
#   github_repo_name                  = each.value.github_repo_name
#   github_source_url                 = each.value.github_source_url
#   trigger_name                      = each.value.trigger_name
#   disabled                          = each.value.disabled
#   push_branch_name_regex            = each.value.push_branch_name_regex
#   artifact_registry_gcp_project_id  = each.value.artifact_registry_gcp_project_id
#   custom_description                = each.value.custom_description
#   cloudbuild_yaml_path              = each.value.cloudbuild_yaml_path
#   tags                              = each.value.tags
  
# }


module "cloudbuild_triggers" {
  #source                            = "github.com/plosso/terraform-gcp-cloudbuild//modules/cloudbuild-triggers"
  source                            = "git::git@github.com:plosso/terraform-gcp-cloudbuild.git//modules/cloudbuild-trigger"
  for_each                          = var.cloudbuild_triggers

  gcp_project_id                    = var.gcp_project_id
  region                            = var.gcp_region
  account_id                        = var.gcp_account_id
 
  github_repo_owner                 = each.value.github_repo_owner
  github_repo_name                  = each.value.github_repo_name
  github_source_url                 = each.value.github_source_url
  trigger_name                      = each.value.trigger_name
  disabled                          = each.value.disabled
  push_branch_name_regex            = each.value.push_branch_name_regex
  release_tag                       = each.value.release_tag
  artifact_registry_gcp_project_id  = each.value.artifact_registry_gcp_project_id
  custom_description                = each.value.custom_description
  cloudbuild_yaml_path              = each.value.cloudbuild_yaml_path
  tags                              = each.value.tags

}

output "cloudbuild_triggers" {
  value = module.cloudbuild_triggers
}

## docker buld automation
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger
### Triggered when pushes are made to feature branches
resource "google_cloudbuild_trigger" "branch_build" {
  name        = "${var.repo_name}-branch-build"
  description = "${var.repo_name}-branch-build"
  filename    = var.build_filename
  github {
    owner = "overjetdental"
    name  = var.repo_name
    push {
      branch       = "^main$"
      invert_regex = true
    }
  }
  service_account = google_service_account.cloudbuild_sa.id
  substitutions = {
      _REPOSITORY = var.repo_name
      _ARTIFACT_REGISTRY_REGION = var.artifact_registry_region
      _ARTIFACT_REGISTRY_PROJECT_ID = var.artifact_registry_project_id
    }
  # labels not supported
}

## To be triggered manually
resource "google_cloudbuild_trigger" "branch_build_deploy" {
  name        = "${var.repo_name}-branch-build-deploy"
  description = "${var.repo_name}-branch-build-deploy"
  git_file_source {
    path      = var.build_deploy_filename
    repo_type = "GITHUB"
    revision  = "refs/heads/main"
    uri       = "https://github.com/overjetdental/${var.repo_name}"
  }

  source_to_build {
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
    uri       = "https://github.com/overjetdental/${var.repo_name}"
  }
  service_account = google_service_account.cloudbuild_sa.id
  substitutions = {
      _REPOSITORY = var.repo_name
      _ARTIFACT_REGISTRY_REGION = var.artifact_registry_region
      _ARTIFACT_REGISTRY_PROJECT_ID = var.artifact_registry_project_id
      _CLUSTER_NAME = "insuranceanalytics-dev-autopilot"
      _CLUSTER_LOCATION = "us-central1"
    }
  # labels not supported
}


#### Triggered when commit is tagged as dev-v*
resource "google_cloudbuild_trigger" "main_build_deploy" {
  name        = "${var.repo_name}-main-build-deploy"
  description = "${var.repo_name}-main-build-deploy"
  filename    = var.build_deploy_tag_filename

  github {
    owner = "overjetdental"
    name  = var.repo_name
    push {
      tag = "^dev-v*"
    }
  }
  service_account = google_service_account.cloudbuild_sa.id
  substitutions = {
      _REPOSITORY = var.repo_name
      _ARTIFACT_REGISTRY_REGION = var.artifact_registry_region
      _ARTIFACT_REGISTRY_PROJECT_ID = var.artifact_registry_project_id
      _CLUSTER_NAME = "insuranceanalytics-dev-autopilot"
      _CLUSTER_LOCATION = "us-central1"
    }
  # labels not supported
}

resource "google_service_account" "cloudbuild_sa" {
  account_id   = "${var.sa_name}-sa"
  display_name = "${var.sa_name}-sa"
}

resource "google_project_iam_member" "act_as" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}
resource "google_project_iam_member" "logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "artifactregistry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "container_service_agent" {
  project = var.project_id
  role    = "roles/container.serviceAgent"
  member  = "serviceAccount:${google_service_account.cloudbuild_sa.email}"
}
