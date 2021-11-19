# frozen_string_literal: true

# Score Service
class ScoreService
  APPS = {
    1 => :artia,
    2 => :twygo,
    3 => :fleeg
  }.freeze

  def initialize(params)
    @activity_id = params[:id].to_i
    @app = APPS[params[:app].to_i]
    @user_id = params[:user_id].to_i
    @role = params[:role]
    @status = status_by_role
  end

  def status_by_role
    case @role
    when 'developer'
      [1941, 31_336]
    when 'tester'
      [26_018]
    end
  end

  def duration
    duration = []
    filter_time_entries.each do |time_entry|
      duration << time_entry['duration'].to_i
    end
    duration.sum
  end

  def calculate
    artia_svc.search_activity(@activity_id, @app)
    duration
  rescue StandardError => e
    Airbrake.notify(e)
  end

  def activity_time_entries
    artia_svc.search_time_entries(@activity_id, @app)
  end

  def filter_time_entries
    activity_time_entries.select do |time_entry|
      status_by_role.include?(time_entry['timeEntryStatusId'].to_i)
    end
  end

  def verify_rules; end

  def artia_svc
    @artia_svc ||= ArtiaService.new(false)
  end
end
