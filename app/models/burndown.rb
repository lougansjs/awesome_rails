# frozen_string_literal: true

# Burndown model
class Burndown < ApplicationRecord
  include BurndownsHelper
  def sprint_days
    skip_weekends((date_start..date_end))
  end

  def score_by_day
    score = {}
    sprint_days.each_with_index do |day, index|
      score[day] = metascore - (index * 3)
    end
    score
  end
end
