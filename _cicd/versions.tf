terraform {
    required_version = "~> 1.2.3"

    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.27.0"        
        }
        github = {
            source = "integrations/github"
            version = "4.26.1"
        }     
    }
}
