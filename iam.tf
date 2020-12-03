data "aws_iam_policy_document" "openvpn_ec2_assume" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    principals {
      type = "AWS"
      identifiers = [
        format("arn:aws:iam::%s:root", var.aws_account_id)
      ]
    }
  }
}

resource "aws_iam_role" "openvpn" {
  name               = "openvpn"
  assume_role_policy = data.aws_iam_policy_document.openvpn_ec2_assume.json
  tags = merge(
    var.tags,
    {
      "SERVICE" = "IAM"
    }
  )
}

data "aws_iam_policy_document" "iam_role" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ec2:AssociateAddress"]
    principals {
      type = "AWS"
      identifiers = [
        format("arn:aws:iam::%s:root", var.aws_account_id)
      ]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "route53:ListHostedZones",
      "route53:GetChange",
    ]
    principals {
      type = "AWS"
      identifiers = [
        format("arn:aws:iam::%s:root", var.aws_account_id)
      ]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = [format("arn:aws:route53:::hostedzone/%s", data.aws_route53_zone.main.zone_id)]
    actions   = ["route53:ChangeResourceRecordSets"]

    principals {
      type = "AWS"
      identifiers = [
        format("arn:aws:iam::%s:root", var.aws_account_id)
      ]
    }
  }
}

resource "aws_iam_role_policy" "openvpn" {
  name   = "openvpn_r53"
  role   = aws_iam_role.openvpn.id
  policy = data.aws_iam_policy_document.iam_role.json
}


data "aws_iam_policy_document" "ssm_s3_access" {
  statement {
    sid    = ""
    effect = "Allow"
    resources = [
      format("%s%s", "arn:aws:s3:::", aws_s3_bucket.ansible_bucket.id),
      format("%s%s/*", "arn:aws:s3:::", aws_s3_bucket.ansible_bucket.id)
    ]

    actions = [
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetEncryptionConfiguration",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]
    principals {
      type = "AWS"
      identifiers = [
        format("arn:aws:iam::%s:root", var.aws_account_id)
      ]
    }
  }
}

resource "aws_iam_policy" "ssm_s3_access" {
  name   = "openvpnas_s3_ssm_access"
  policy = data.aws_iam_policy_document.ssm_s3_access.json
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
  name = "openvpn"
  role = aws_iam_role.openvpn.name
}
