resource "aws_iam_policy" "github_access_policy" {
  name = "github-access-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull",
        "codecommit:GitPush"
      ],
      "Resource": "${var.aws-repo-name}"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_access_policy" {
  name = "s3-access-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${var.aws-s3}",
        "${var.aws-s3}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "s3_policy_attachment" {
  user       = aws_iam_user.github_actions_user.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_user_policy_attachment" "github_policy_attachment" {
  user       = aws_iam_user.github_actions_user.name
  policy_arn = aws_iam_policy.github_access_policy.arn
}
