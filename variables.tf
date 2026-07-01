variable "source_role_arn" {
  type        = string
  description = "Role ARN in source AWS account"

  validation {
    condition     = can(regex("^arn:aws:iam::[[:digit:]]{12}:.+", var.source_role_arn))
    error_message = "Must be a valid AWS IAM role ARN."
  }
}

variable "external_id" {
  type        = string
  default     = null
  description = "External ID for link verification. Required when `api = true`"

  validation {
    condition     = var.api == false || var.external_id != null
    error_message = "external_id is required when api is true."
  }
}

variable "administrator" {
  type        = bool
  default     = false
  description = "ReadOnly or Administrator Access. Used as fallback for the console/api roles when `policy_arns` is empty"
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "Policy ARNs to attach to the console and API roles. Takes precedence over `administrator` when set. When empty, `administrator` selects AdministratorAccess (true) or ReadOnlyAccess (false)"

  validation {
    condition     = alltrue([for arn in var.policy_arns : can(regex("^arn:aws:iam::(aws|[[:digit:]]{12}):policy/.+", arn))])
    error_message = "Each entry must be a valid IAM policy ARN."
  }
}

variable "console" {
  type        = bool
  default     = true
  description = "Create a console access role"
}

variable "api" {
  type        = bool
  default     = true
  description = "Create an API access role"
}

variable "destination_role_name_prefix" {
  type        = string
  default     = "zzzzz-"
  description = "Prefix for role names in destination AWS account"
}

variable "destination_role_name_api" {
  type        = string
  default     = null
  description = "Role name for API access in destination AWS account"
}

variable "destination_role_name_console" {
  type        = string
  default     = null
  description = "Role name for Console access in destination AWS account"
}

variable "billing" {
  type        = bool
  default     = false
  description = "Create a billing role with read-only billing console access"
}

variable "destination_role_name_billing" {
  type        = string
  default     = null
  description = "Role name for billing access in destination AWS account"
}

variable "assume_from_sso" {
  type = list(object({
    aws_source_account_id    = string
    sso_region               = string
    sso_permissions_set_name = string
  }))
  default = []
  validation {

    condition     = alltrue([for sso in var.assume_from_sso : can(regex("^[[:digit:]]{12}", sso.aws_source_account_id))])
    error_message = "Must be a valid AWS IAM account number."
  }
  validation {
    condition     = alltrue([for sso in var.assume_from_sso : can(regex("[a-z][a-z]-[a-z]+-[1-9]", sso.sso_region))])
    error_message = "Must be valid AWS Region names."
  }
  description = "List of objects containing `aws_source_account_id`, `sso_region` and `sso_permissions_set_name` to be allowed to assume console and billing roles"
}
