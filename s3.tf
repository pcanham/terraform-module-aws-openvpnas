resource "aws_s3_bucket" "ansible_bucket" {
  bucket = lower(format("%s-%s-ansible",
    random_pet.node.id,
    var.environment_tag,
  ))
  acl           = "private"
  force_destroy = true
  tags = merge(
    local.common_tags,
    {
      "SERVICE" = "STORAGE"
    }
  )
}

# Add ansible playbook to S3
resource "aws_s3_bucket_object" "openvpn_playbook" {
  bucket = aws_s3_bucket.ansible_bucket.id
  key    = "lab/openvpn.yml"
  source = "ansible/main.yml"
  etag   = filemd5("ansible/main.yml")
  tags = merge(
    local.common_tags,
    {
      "SERVICE" = "STORAGE"
    }
  )
}
