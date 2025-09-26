# frozen_string_literal: true

# Helpers for burndowns
module BurndownsHelper
  def skip_weekends(array_dates)
    array_dates.reject { |date| date.to_date.saturday? || date.to_date.sunday? }
  end

  def set_progress(burndown)
    date_current = Date.current
    days = burndown.planned_by_day.size
    days_past = (burndown.sprint_days_past.size + 1)
    progress = ((days_past.to_f / days.to_f) * 100).to_i
    return progress if progress <= 100
  end

  def progress_burndown(burndown)
    return { title: 'Pronta para iniciar', class: 'danger' } if burndown.burndown_is_pending?
    return { title: 'Finalizada', class: 'success' } if burndown.burndown_is_finished?

    if burndown.status == Burndown::STATUS[:in_progress]
      progress = set_progress(burndown)
      { title: 'Em andamento', class: 'progress-bar bg-warning', progress: progress }
    end
  end
end
