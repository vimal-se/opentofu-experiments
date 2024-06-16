provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "tf-bucket-quick-start-my-app-data" {
  bucket = "tf-bucket-quick-start-my-app-data"

  tags = {
    Name        = "My Quick Start Bucket"
  }
}