# frozen_string_literal: true

# This worker is responsible for updating the next burndown
class NextBurndown
  include Sidekiq::Worker
  sidekiq_options queue: 'next-burndown'

  def perform
    burndown = Burndown.where(in_use: true, status: 1).first
    yesterday = Date.current.yesterday
    next_burndown(burndown) if burndown.date_end == yesterday
  end

  def next_burndown(burndown)
    sprint = burndown.sprint
    next_burndown = Burndown.where(sprint: (sprint + 1), in_use: false).first
    unless next_burndown.present?
      date_start = Date.current
      date_end = date_start + 1.9.weeks
      next_burndown = Burndown.create(
        sprint: (sprint + 1),
        date_start: date_start,
        date_end: date_end,
        metascore: 30
      )
    end
    burndown.finish_burndown!
    next_burndown.start_burndown!
    burndown.save
    next_burndown.save
  end
end
