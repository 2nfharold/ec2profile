variable "iam_policy_statements" {
  type = list(object({
    sid    = string
    effect = string
    principals = object({
      type        = optional(string)
      identifiers = list(string)
    })
    actions   = list(string)
    resources = list(string)
  }))
}

variable "iam_role_name" {
  type = string
}

variable "iam_role_description" {
  type = string
}

variable "iam_role_path" {
  type = string
}

variable "other_policy_arns" {
  type = list(string)
}

variable "instance_profile_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}

variable "AWS_REGION" {
  type = string
}
