variable "combiner" {
  type        = string
  default     = "OR"
  description = "Alert policy condition combiner."

  validation {
    condition     = contains(["AND", "AND_WITH_MATCHING_RESOURCE", "OR", ], var.combiner)
    error_message = "The specified combiner is invalid."
  }
}

#variable "conditions_absent" {
#}

variable "conditions_threshold" {
  type = list(object({
    display_name         = string
    comparison           = string
    duration             = number
    filter               = string
    threshold_value      = number
    alignment_period     = number
    cross_series_reducer = string
    group_by_fields      = list(string)
    per_series_aligner   = string
    trigger_count        = number
    trigger_percent      = number
  }))

  validation {
    condition = alltrue([
      for condition in var.conditions_threshold :
      contains(["COMPARISON_GT", "COMPARISON_GE", "COMPARISON_LT", "COMPARISON_LE", "COMPARISON_EQ", "COMPARISON_NE"], condition.comparison)
    ])
    error_message = "The specified comparison is not valid."
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
