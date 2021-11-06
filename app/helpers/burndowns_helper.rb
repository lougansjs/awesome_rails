# frozen_string_literal: true

# Helpers for burndowns
module BurndownsHelper
  def skip_weekends(array_dates)
    array_dates.reject { |date| date.to_date.saturday? || date.to_date.sunday? }
  end

  def progress_burndown(burndown)
    if burndown.status == Burndown::STATUS[:pending]
      return { title: 'Pronta para iniciar', class: 'danger' }
    end
    if burndown.status == Burndown::STATUS[:finished]
      return { title: 'Finalizada', class: 'success' }
    end

    if burndown.status == Burndown::STATUS[:in_progress]
      date_current = Date.current
      days = burndown.planned_by_day.size
      days_past = (burndown.sprint_days_past.size + 1)
      progress = ((days_past.to_f / days.to_f) * 100).to_i
      if progress < 100
        { title: 'Em andamento', class: 'progress-bar bg-warning', progress: progress }
      end
    end
  end
end
