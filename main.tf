data "aws_iam_policy_document" "cookielab_assume_console" {
  statement {
    effect = "Allow"

    sid = "RequireMFAForAssumeConsole"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "AWS"
      identifiers = [var.source_role_arn]
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }

  dynamic "statement" {
    for_each = var.assume_from_sso

    content {
      effect = "Allow"

      sid = "RequireSSOAuthedForAssumeConsole${statement.key}"
      actions = [
        "sts:AssumeRole"
      ]

      principals {
        type        = "AWS"
        identifiers = [var.source_role_arn]
      }

      condition {
        test     = "StringLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:aws:iam::${statement.value["aws_source_account_id"]}:role/aws-reserved/sso.amazonaws.com/${statement.value["sso_region"]}/AWSReservedSSO_${statement.value["sso_permissions_set_name"]}_????????????????"]
      }
    }
  }
}

resource "aws_iam_role" "cookielab_console" {
  count = var.console == true ? 1 : 0

  name = var.destination_role_name_console == null ? "${var.destination_role_name_prefix}cookielab-console" : var.destination_role_name_console

  assume_role_policy = data.aws_iam_policy_document.cookielab_assume_console.json
}

data "aws_iam_policy_document" "cookielab_assume_api" {
  count = var.api == true ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "AWS"
      identifiers = [var.source_role_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id]
    }
  }
}

resource "aws_iam_role" "cookielab_api" {
  count = var.api == true ? 1 : 0

  name = var.destination_role_name_api == null ? "${var.destination_role_name_prefix}cookielab-api" : var.destination_role_name_api

  assume_role_policy = data.aws_iam_policy_document.cookielab_assume_api[0].json
}

resource "aws_iam_role_policy_attachment" "cookielab_console_ro" {
  count = var.console == true && var.administrator == false ? 1 : 0

  role       = aws_iam_role.cookielab_console[0].name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "cookielab_api_ro" {
  count = var.api == true && var.administrator == false ? 1 : 0

  role       = aws_iam_role.cookielab_api[0].name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "cookielab_console_admin" {
  count = var.console == true && var.administrator == true ? 1 : 0

  role       = aws_iam_role.cookielab_console[0].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "cookielab_api_admin" {
  count = var.api == true && var.administrator == true ? 1 : 0

  role       = aws_iam_role.cookielab_api[0].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "cookielab_billing" {
  count = var.billing == true ? 1 : 0

  name = var.destination_role_name_billing == null ? "${var.destination_role_name_prefix}cookielab-billing" : var.destination_role_name_billing

  assume_role_policy = data.aws_iam_policy_document.cookielab_assume_console.json
}

resource "aws_iam_role_policy_attachment" "cookielab_billing_ro" {
  count = var.billing == true ? 1 : 0

  role       = aws_iam_role.cookielab_billing[0].name
  policy_arn = "arn:aws:iam::aws:policy/AWSBillingReadOnlyAccess"
}
