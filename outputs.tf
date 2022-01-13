output "console_role_name" {
  value = aws_iam_role.cookielab_console.name
}

output "console_role_arn" {
  value = aws_iam_role.cookielab_console.arn
}

output "api_role_name" {
  value = aws_iam_role.cookielab_api.name
}

output "api_role_arn" {
  value = aws_iam_role.cookielab_api.arn
}
