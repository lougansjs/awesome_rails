# frozen_string_literal: true

# Controller for Burndowns
class BurndownsController < ApplicationController
  before_action :authenticate_user!
  def index
    @burndown = Burndown.where("'#{Date.today}' between date_start AND date_end").first
    planned = @burndown.planned_by_day
    activities = artia_svc.count_activities(@burndown.mapping_passed_days)
    executed = @burndown.executed_by_day(activities)
    @series = [{ name: 'Planejado', data: planned }, { name: 'Realizado', data: executed }]
    @options = { theme: 'rainbow' }
  end

  def artia_svc
    @artia_svc = ArtiaService.new
  end
end
