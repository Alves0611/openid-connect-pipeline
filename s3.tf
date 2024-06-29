resource "aws_s3_bucket" "this" {
  bucket = random_pet.bucket.id
}

resource "random_pet" "bucket" {
  length = 3
}
