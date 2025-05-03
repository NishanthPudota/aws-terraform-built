terraform {
  backend "s3" {
    bucket         = "aws_terraform_build_version"
    key            = "env/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
