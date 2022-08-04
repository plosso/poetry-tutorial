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
  region                            = var.region
  github_repo_owner                 = each.value.github_repo_owner
  github_repo_name                  = each.value.github_repo_name
  github_source_url                 = each.value.github_source_url
  trigger_name                      = each.value.trigger_name
  disabled                          = each.value.disabled
  push_branch_name_regex            = each.value.push_branch_name_regex
  artifact_registry_gcp_project_id  = each.value.artifact_registry_gcp_project_id
  custom_description                = each.value.custom_description
  cloudbuild_yaml_path              = each.value.cloudbuild_yaml_path
  tags                              = each.value.tags

}

output "cloudbuild_triggers" {
  value = module.cloudbuild_triggers
}