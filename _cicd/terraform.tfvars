gcp_project_id    = "cloudbuild-testing-354715"

cloudbuild_triggers = {

    "push-to-main" = {
        trigger_name                      = "push-to-main"
        disabled                          = false
        github_source_url                 = "https://github.com/plosso/docker-compose-tutorial"
        github_repo_owner                 = "plosso"
        github_repo_name                  = "docker-compose-tutorial"
        trunk_branch_name                 = "main"
        push_branch_name_regex            = "main"
        gcp_project_id                    = "cloudbuild-testing-354715"
        artifact_registry_gcp_project_id  = "cloudbuild-testing-354715"
        custom_description                = "Cloudbuild run for push-to-main trigger"
        cloudbuild_yaml_path              = "_cicd/push_cloudbuild.yaml"
        tags                              = ["docker"]
    },
    "build-wheel" = {
        trigger_name                      = "build-wheel"
        disabled                          = false
        github_source_url                 = "https://github.com/plosso/poetry-tutorial"
        github_repo_owner                 = "plosso"
        github_repo_name                  = "poetry-tutorial"
        trunk_branch_name                 = "main"
        push_branch_name_regex            = "main"
        gcp_project_id                    = "cloudbuild-testing-354715"
        artifact_registry_gcp_project_id  = "cloudbuild-testing-354715"
        custom_description                = "Cloudbuild run for building Pythan wheel trigger"
        cloudbuild_yaml_path              = "_cicd/build_wheel.yaml"
        tags                              = ["Python"]
    }


}