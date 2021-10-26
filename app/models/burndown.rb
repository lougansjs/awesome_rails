# frozen_string_literal: true

# Burndown model
class Burndown < ApplicationRecord
  include BurndownsHelper

  validates :date_start, :date_end, :metascore, :sprint, presence: true
  validate :verify_rules

  def sprint_days
    skip_weekends((date_start..date_end))
  end

  def sprint_days_past
    sprint_days.select(&:past?)
  end

  def sprint_days_future
    sprint_days.select(&:future?)
  end

  def remaining_days_by_date(date)
    sprint_days.select { |day| day >= date }.size
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
    # counts = counts.unshift(0)
    metascore = self.metascore
    days = sprint_days
    days.each_with_index do |day, idx1|
      counts.each_with_index do |count, idx2|
        if idx1 == idx2
          score[day] = metascore - count
          metascore -= count
        end
      end
    end
    score
  end

  def verify_rules
    errors.add('Meta', 'deve ser maior que zero') if metascore.zero?
    errors.add('Sprint', 'deve ser maior que zero') if sprint.zero?

    if date_start > date_end
      errors.add('Data de início', 'deve ser menor que data final')
    end
    if date_end < date_start
      errors.add('Data de término', 'deve ser maior que data inicial')
    end

    if burndown_by_sprint(sprint).exists?
      errors.add('Sprint', 'já existe um gráfico para essa sprint')
    end
  end

  def burndown_by_sprint(sprint)
    Burndown.where(sprint: sprint)
  end
end
