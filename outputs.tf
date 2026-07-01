output "console_role_name" {
  value = var.console == true ? aws_iam_role.cookielab_console[0].name : null
}

output "console_role_arn" {
  value = var.console == true ? aws_iam_role.cookielab_console[0].arn : null
}

output "api_role_name" {
  value = var.api == true ? aws_iam_role.cookielab_api[0].name : null
}

output "api_role_arn" {
  value = var.api == true ? aws_iam_role.cookielab_api[0].arn : null
}

output "billing_role_name" {
  value = var.billing == true ? aws_iam_role.cookielab_billing[0].name : null
}

output "billing_role_arn" {
  value = var.billing == true ? aws_iam_role.cookielab_billing[0].arn : null
}
