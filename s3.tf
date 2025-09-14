resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-bucket-12345"

  acl    = "public-read"  # ❌ Publicly accessible bucket

  versioning {
    enabled = false  # ❌ No versioning for rollback or recovery
  }

  server_side_encryption_configuration {
    # ❌ Encryption is intentionally omitted
  }
}
