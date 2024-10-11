# IAM Policy
data "aws_iam_policy_document" "iam_policy" {
  dynamic "statement" {
    for_each = { for statement in var.iam_policy_statements : statement.sid => statement }

    content {
      sid    = statement.value.sid
      effect = statement.value.effect

      principals {
        type        = statement.value.principals.type
        identifiers = statement.value.principals.identifiers
      }

      actions   = statement.value.actions
    }
  }
}

# IAM Role
resource "aws_iam_role" "iam_role" {
  name               = var.iam_role_name
  description        = var.iam_role_description
  path               = var.iam_role_path
  assume_role_policy = data.aws_iam_policy_document.iam_policy.json

  tags = {
    Name = var.iam_role_name
  }
}

# Attach more policies to role
resource "aws_iam_role_policy_attachment" "other_policies" {
  for_each = toset([for policy_arn in var.other_policy_arns : policy_arn])

  role       = aws_iam_role.iam_role.name
  policy_arn = each.value
}

# EC2 Instance Profile
resource "aws_iam_instance_profile" "instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.iam_role.name

  tags = merge(var.tags, {
    Name = var.instance_profile_name
  })
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.instance_profile.name
}
