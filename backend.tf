terraform {
  backend "s3" {
    bucket         = "aws-terraform-build-version"
    key            = "env/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
