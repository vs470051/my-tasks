
output "S3_bucketsrn" {
  value = aws_s3_bucket.s3bucket.arn
}

output "s3_bucketname" {
  value = aws_s3_bucket.s3bucket.id
}