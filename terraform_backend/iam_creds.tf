resource "aws_iam_user" "terraform_backend" {
  name = "lit-graph-terraform-backend-terraform-user"
  path = "/terraform/"
}

resource "aws_iam_user_policy" "terraform_backend" {
  name   = "${aws_iam_user.terraform_backend.name}-policy"
  user   = aws_iam_user.terraform_backend.name
  policy = data.aws_iam_policy_document.terraform_backend.json
}


data "aws_iam_policy_document" "terraform_backend" {
    statement {
      effect = "Allow"
      actions = [
        "s3:ListBucket",
      ]
      resources = [
        aws_s3_bucket.backend.arn,
      ]
    }

    statement {
        effect = "Allow"
        actions = [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject",
        ]
        resources = [
            "${aws_s3_bucket.backend.arn}/*",
        ]
    }

    statement {
        effect = "Allow"
        actions = [
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem",
            "dynamodb:UpdateItem",
            "dynamodb:DescribeTable",
        ]
        resources = [
            aws_dynamodb_table.backend_lock.arn,
        ]
    }
}

resource "aws_iam_access_key" "terraform_backend" {
  user = aws_iam_user.terraform_backend.name
}

output "iam_access_key_id" {
  value = aws_iam_access_key.terraform_backend.id
  sensitive = true
}

output "iam_access_key_secret" {
  value = aws_iam_access_key.terraform_backend.secret
  sensitive = true
}