resource "aws_iam_role" "openvpn" {
  name               = "openvpn"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [ { "Effect": "Allow", "Principal": { "Service": "ec2.amazonaws.com" }, "Action": "sts:AssumeRole" } ]
}
EOF
  tags = merge(
    var.tags,
    {
      "SERVICE" = "IAM"
    }
  )
}

resource "aws_iam_role_policy" "openvpn" {
  name = "openvpn_r53"
  role = aws_iam_role.openvpn.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    { "Action" : ["ec2:AssociateAddress"], "Effect": "Allow", "Resource": ["*"] },
    { "Action" : ["route53:ListHostedZones", "route53:GetChange"], "Effect": "Allow", "Resource": ["*"] },
    { "Action" : ["route53:ChangeResourceRecordSets"], "Effect": "Allow", "Resource": ["arn:aws:route53:::hostedzone/${data.aws_route53_zone.main.zone_id}"] }
  ]
}
EOF
}

resource "aws_iam_policy" "ssm_s3_access" {
  name   = "openvpnas_s3_ssm_access"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
  "Effect": "Allow",
  "Action": [
    "s3:GetBucketLocation",
    "s3:PutObject",
    "s3:GetObject",
    "s3:GetEncryptionConfiguration",
    "s3:AbortMultipartUpload",
    "s3:ListMultipartUploadParts",
    "s3:ListBucket",
    "s3:ListBucketMultipartUploads"
  ],
  "Resource": "*"
  }
]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_s3_policy_attachment" {
  role       = aws_iam_role.openvpn.name
  policy_arn = aws_iam_policy.ssm_s3_access.arn
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy01" {
  role       = aws_iam_role.openvpn.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy02" {
  role       = aws_iam_role.openvpn.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "openvpn" {
  name  = "openvpn"
  role  = aws_iam_role.openvpn.name
}
