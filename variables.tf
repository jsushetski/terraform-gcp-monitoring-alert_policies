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
#  type = list(object({
#  }))
#  description = "A list of objects representing absent conditions."
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
  description = "A list of objects representing threshold conditions."

  validation {
    condition = alltrue([
      for condition in var.conditions_threshold :
      contains(["COMPARISON_GT", "COMPARISON_GE", "COMPARISON_LT", "COMPARISON_LE", "COMPARISON_EQ", "COMPARISON_NE"], condition.comparison)
    ])
    error_message = "The value of 'comparison' is not valid."
  }

  validation {
    condition = alltrue([
      for condition in var.conditions_threshold :
      condition.duration >= 1 && condition.duration <= 60
    ])
    error_message = "The value of 'duration' must be between 1 and 60."
  }

  validation {
    condition = alltrue([
      for condition in var.conditions_threshold :
      contains(["REDUCE_NONE", "REDUCE_MEAN", "REDUCE_MIN", "REDUCE_MAX", "REDUCE_SUM", "REDUCE_STDDEV", "REDUCE_COUNT", "REDUCE_COUNT_TRUE", "REDUCE_COUNT_FALSE", "REDUCE_FRACTION_TIME", "REDUCE_PERCENTILE_99", "REDUCE_PERCENTILE_95", "REDUCE_PERCENTILE_50", "REDUCE_PERCENTILE_05"], condition.cross_series_reducer)
    ])
    error_message = "The value of 'cross_series_reducer' is not valid."
  }

  validation {
    condition = alltrue([
      for condition in var.conditions_threshold :
      contains(["ALIGN_NONE", "ALIGN_DELTA", "ALIGN_RATE", "ALIGN_INTERPOLATE", "ALIGN_NEXT_OLDER", "ALIGN_MIN", "ALIGN_MAX", "ALIGN_MEAN", "ALIGN_COUNT", "ALIGN_SUM", "ALIGN_STDDEV", "ALIGN_COUNT_TRUE", "ALIGN_COUNT_FALSE", "ALIGN_FRACTION_TRUE", "ALIGN_PERCENTILE_99", "ALIGN_PERCENTILE_95", "ALIGN_PERCENTILE_50", "ALIGN_PERCENTILE_05", "ALIGN_PERCENTILE_CHANGE"], condition.per_series_aligner)
    ])
    error_message = "The value of 'per_series_aligner' is not valid."
  }

  validation {
    condition = alltrue([
      for condition in var.conditions_threshold :
      condition.trigger_percent >= 0 && condition.duration <= 100
    ])
    error_message = "The value of 'trigger_percent' must be between 0 and 100."
  }
}

variable "display_name" {
  type        = string
  description = "Alert policy display name."
}

variable "enable" {
  type        = bool
  default     = true
  description = "Enables creation of the alert policy."
}

variable "notification_channels" {
  type        = list(string)
  default     = []
  description = "A list of notification channels to be notified when the alert policy triggers."
}

variable "project" {
  type        = string
  description = "GCP project name."
}
