resource "aws_iam_role" "openvpn" {
  count              = var.create_openvpnas ? 1 : 0
  name               = "openvpn"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [ { "Effect": "Allow", "Principal": { "Service": "ec2.amazonaws.com" }, "Action": "sts:AssumeRole" } ]
}
EOF
}

resource "aws_iam_role_policy" "openvpn" {
  count = var.create_openvpnas ? 1 : 0
  name = "openvpn"
  role = aws_iam_role.openvpn[0].id
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

resource "aws_iam_instance_profile" "openvpn" {
  count = var.create_openvpnas ? 1 : 0
  name  = "openvpn"
  role  = aws_iam_role.openvpn[0].name
}
