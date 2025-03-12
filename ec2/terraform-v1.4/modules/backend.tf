terraform {
  backend "s3" {
    bucket = "gitlab-remote-state"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"
    lock = true
  }
}
