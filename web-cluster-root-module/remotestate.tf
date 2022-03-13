terraform {
  backend "s3" {
    bucket = "devops-terraform-state-bucket-2022"
    key    = "web_cluster"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
    region = "ap-south-1"
  }
}
