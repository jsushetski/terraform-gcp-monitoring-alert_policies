resource "google_monitoring_alert_policy" "alert_policy" {
  provider = google

  display_name = var.display_name

  combiner = var.combiner

  # threshold conditions
  dynamic "conditions" {
    for_each = var.conditions_threshold
    iterator = condition

    content {
      display_name = condition.value.display_name

      condition_threshold {
        comparison      = condition.value.comparison
        duration        = "${condition.value.duration}s"
        filter          = condition.value.filter
        threshold_value = condition.value.threshold_value

        aggregations {
          alignment_period     = condition.value.alignment_period
          cross_series_reducer = condition.value.cross_series_reducer
          group_by_fields      = condition.value.group_by_fields
          per_series_aligner   = condition.value.per_series_aligner
        }

        trigger {
          count   = condition.value.trigger_count
          percent = condition.value.trigger_percent
        }
      }
    }
  }
}
