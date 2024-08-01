terraform {

  required_providers {
    
    aws = {
      source  = "hashicorp/aws"
    }
    
  }
  cloud {
    organization = "A-Hannora-Systems"

    workspaces {
      name = "k8s-jenkins-kh-project"
    }
  }
}
