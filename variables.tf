variable "combiner" {
  type        = string
  default     = "OR"
  description = "Alert policy condition combiner."

  validation {
    condition     = contains(["AND", "AND_WITH_MATCHING_RESOURCE", "OR",], var.combiner)
    error_message = "The specified combiner is invalid."
  }
}

variable "display_name" {
  type        = string
  description = "Alert policy display name."
}

variable "project" {
  type        = string
  description = "GCP project name."
}
