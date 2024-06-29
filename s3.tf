resource "aws_s3_bucket" "this" {
  bucket        = "${random_pet.bucket.id}-tfstate"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "random_pet" "bucket" {
  length = 2
}
