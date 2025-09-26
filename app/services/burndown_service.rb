# frozen_string_literal: true

# BurndownService
class BurndownService
  def data
    burndown = load_burndown
    return burndown if burndown[:default]

    sprint = burndown.sprint
    planned = burndown.planned_by_day
    activities = artia_svc.count_activities(burndown.mapping_passed_days)
    executed = burndown.executed_by_day(activities)
    series_planned = Burndown::SERIES[0].merge(data: planned)
    series_executed = Burndown::SERIES[1].merge(data: executed)
    {
      series: [series_planned, series_executed],
      options: Burndown::OPTIONS,
      sprint: sprint
    }
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def load_burndown
    date_current = Date.current.strftime('%Y-%m-%d')
    burndown = Burndown.where("'#{date_current}' between date_start AND date_end")
                       .where(in_use: true).first
    burndown || Burndown.new.default_burndown
  rescue StandardError => e
    puts e.message
    Airbrake.notify(e)
  end

  def artia_svc
    @artia_svc = ArtiaService.new
  end
end
