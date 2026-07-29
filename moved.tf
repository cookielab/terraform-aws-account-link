# Migrate the console/api roles from unindexed addresses to count[0], added
# with the `console`/`api` toggles.

moved {
  from = aws_iam_role.cookielab_console
  to   = aws_iam_role.cookielab_console[0]
}

moved {
  from = aws_iam_role.cookielab_api
  to   = aws_iam_role.cookielab_api[0]
}

# Migrate the previous count-based ReadOnly/Administrator policy attachments
# to the new for_each attachments keyed by policy ARN. Whichever attachment
# actually exists in state (ro or admin, per the `administrator` toggle) is
# moved; the other block is a no-op because its source is absent from state.

moved {
  from = aws_iam_role_policy_attachment.cookielab_console_ro[0]
  to   = aws_iam_role_policy_attachment.cookielab_console["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

moved {
  from = aws_iam_role_policy_attachment.cookielab_console_admin[0]
  to   = aws_iam_role_policy_attachment.cookielab_console["arn:aws:iam::aws:policy/AdministratorAccess"]
}

moved {
  from = aws_iam_role_policy_attachment.cookielab_api_ro[0]
  to   = aws_iam_role_policy_attachment.cookielab_api["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

moved {
  from = aws_iam_role_policy_attachment.cookielab_api_admin[0]
  to   = aws_iam_role_policy_attachment.cookielab_api["arn:aws:iam::aws:policy/AdministratorAccess"]
}
