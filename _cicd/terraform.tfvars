gcp_project_id    = "cloudbuild-testing-354715"

cloudbuild_triggers = {

    "main-merge" = {
        trigger_name                      = "push-to-main"
        disabled                          = false
        github_source_url                 = "https://github.com/plosso/docker-compose-tutorial"
        github_repo_owner                 = "plosso"
        github_repo_name                  = "docker-compose-tutorial"
        trunk_branch_name                 = "main"
        push_branch_name_regex            = "main"
        artifact_registry_gcp_project_id  = "cloudbuild-testing-354715"
        custom_description                = "Cloudbuild run for push-to-main trigger"
        cloudbuild_yaml_path              = "_cicd/push_cloudbuild.yaml"
        tags                              = ["docker"]
    },
    "build-wheel-pkg" = {
        trigger_name                      = "build-wheel-pkg"
        disabled                          = false
        github_source_url                 = "https://github.com/plosso/poetry-tutorial"
        github_repo_owner                 = "plosso"
        github_repo_name                  = "poetry-tutorial"
        trunk_branch_name                 = "main"
        push_branch_name_regex            = "main"
        artifact_registry_gcp_project_id  = "cloudbuild-testing-354715"
        custom_description                = "Cloudbuild run for building Pythan wheel trigger"
        cloudbuild_yaml_path              = "_cicd/build_wheel.yaml"
        tags                              = ["Python"]
    }


}