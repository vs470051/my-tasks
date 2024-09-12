
resource "random_id" "bucket" {
  byte_length = 10
}

resource "aws_s3_bucket" "s3bucket" {
  bucket        = "${var.Bucket_name}-${random_id.bucket.hex}"
  force_destroy = var.force_destroy
  tags = {
    Name = "Wordpress-bucket"
  }
  
}