#tfsec:ignore:AWS002
resource "aws_s3_bucket" "ansible_bucket" {
  bucket        = var.s3_bucket_name
  acl           = "private"
  force_destroy = true
  tags = merge(
    var.tags,
    {
      "SERVICE" = "STORAGE"
    }
  )
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Add ansible playbook to S3
resource "aws_s3_bucket_object" "openvpn_playbook" {
  bucket = aws_s3_bucket.ansible_bucket.id
  key    = "lab/openvpn.yml"
  source = var.ssm_playbook_location == "" ? "${path.module}/ansible/main.yml" : var.ssm_playbook_location
  etag   = var.ssm_playbook_location == "" ? filemd5("${path.module}/ansible/main.yml") : filemd5(var.ssm_playbook_location)
  tags = merge(
    var.tags,
    {
      "SERVICE" = "STORAGE"
    }
  )
}
