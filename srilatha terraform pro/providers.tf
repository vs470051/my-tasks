

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  backend "s3" {
    bucket         = "s3-sirish-demo"
    key            = "dev/terraformstatefile"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-state-lock"
    access_key = "${access_key}"
    secret_key = "${secret_key}"
  

  }

}

provider "aws" {
  
  access_key = "${access_key}"
  secret_key = "${secret_key}"
  region     = "${region}"

}

provider "aws" {
  alias  = "test"
  region = "us-east-2"
}