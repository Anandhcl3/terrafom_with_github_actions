terraform {
  backend "s3" {
    bucket = "devops-terraform-state-bucket-2022"
    key    = "web_cluster_with_GIHUBACTION-v1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt = true
    region = "ap-south-1"
  }
}
