# frozen_string_literal: true

# Burndown model
class Burndown < ApplicationRecord
  include BurndownsHelper

  def sprint_days
    skip_weekends((date_start..date_end))
  end

  def mapping_passed_days
    list = []
    sprint_days.each do |day|
      list << day if day.past? || day.today?
    end
    list
  end

  def planned_by_day
    score = {}
    sprint_days.each_with_index do |day, index|
      score[day] = metascore - (index * 3)
    end
    score
  end

  def executed_by_day(counts)
    score = {}
    counts = counts.unshift(0)
    days = sprint_days
    days.each_with_index do |day, idx1|
      counts.each_with_index do |count, idx2|
        if idx1 == idx2
          score[day] = metascore - count
          self.metascore -= count
        end
      end
    end
    score
  end
end
