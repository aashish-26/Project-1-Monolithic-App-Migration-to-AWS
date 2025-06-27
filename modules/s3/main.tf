resource "aws_s3_bucket" "static" {
  bucket = "skymet-static-assets"
  force_destroy = true

  tags = {
    Name = "skymet-static-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.static.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = ["s3:GetObject"],
        Resource = ["${aws_s3_bucket.static.arn}/*"]
      }
    ]
  })
}

output "bucket_name" {
  value = aws_s3_bucket.static.id
}
