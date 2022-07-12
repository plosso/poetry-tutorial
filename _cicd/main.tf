module "cloudbuild_triggers" {
  source    = "./cloudbuild"
  for_each  = var.cloudbuild_triggers

  gcp_project_id                    = var.gcp_project_id
  
  github_repo_owner                 = each.value.github_repo_owner
  github_repo_name                  = each.value.github_repo_name
  github_source_url                 = each.value.github_source_url
  trigger_name                      = each.value.trigger_name
  disabled                          = each.value.disabled
  trunk_branch_name                 = each.value.trunk_branch_name
  push_branch_name_regex            = each.value.push_branch_name_regex
  artifact_registry_gcp_project_id  = each.value.artifact_registry_gcp_project_id
  custom_description                = each.value.custom_description
  cloudbuild_yaml_path              = each.value.cloudbuild_yaml_path
  tags                              = each.value.tags
  
}