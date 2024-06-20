#tfsec:ignore:AWS002
resource "aws_s3_bucket" "ansible_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
  tags = merge(
    var.tags,
    {
      "SERVICE" = "STORAGE"
    }
  )
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ansible_bucket" {
  bucket = aws_s3_bucket.ansible_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "ansible_bucket" {
  bucket = aws_s3_bucket.ansible_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "ansible_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.ansible_bucket]

  bucket = aws_s3_bucket.ansible_bucket.id
  acl    = "private"
}

# Add ansible playbook to S3
resource "aws_s3_object" "openvpn_playbook" {
  for_each = fileset(var.ssm_playbook_location == "" ? "${path.module}/ansible/" : var.ssm_playbook_location, "**/*.*")
  bucket   = aws_s3_bucket.ansible_bucket.bucket
  key      = "lab/${each.value}"
  source   = var.ssm_playbook_location == "" ? "${path.module}/ansible/${each.value}" : "${var.ssm_playbook_location}/${each.value}"
  etag     = var.ssm_playbook_location == "" ? filemd5("${path.module}/ansible/${each.value}") : filemd5("${var.ssm_playbook_location}/${each.value}")
  tags = merge(
    var.tags,
    {
      "SERVICE" = "STORAGE"
    }
  )
}
