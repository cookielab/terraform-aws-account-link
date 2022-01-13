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
  description = "External ID for link verification"
}

variable "administrator" {
  type        = bool
  default     = false
  description = "ReadOnly or Administrator Access"
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
