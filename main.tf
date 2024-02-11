terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "aws_iam_user" "honeytokens_users" {
  for_each      = var.users
  name          = each.key
  path          = "/${var.user_prefix}/"
  tags          = each.value
  force_destroy = true
}

resource "aws_iam_access_key" "honeytokens_keys" {
  for_each   = var.users
  user       = aws_iam_user.honeytokens_users[each.key].name
  depends_on = [aws_iam_user.honeytokens_users]
}
