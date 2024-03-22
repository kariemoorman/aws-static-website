resource "aws_iam_user" "github_actions_user" {
  name = var.gh-actions-username
}

# resource "aws_iam_access_key" "gh-user-access" {
#   user = aws_iam_user.github_actions_user.name
# }
