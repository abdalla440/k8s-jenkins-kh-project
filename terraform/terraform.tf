terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "remote" {
    hostname = "app.terraform.io"    
    organization = "A-Hannora-Systems"
    workspaces {
      name = "k8s-jenkins-kh-project"
    }
  }
}