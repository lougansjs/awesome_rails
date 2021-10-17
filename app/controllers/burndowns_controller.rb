# frozen_string_literal: true

# Controller for Burndowns
class BurndownsController < ApplicationController
  before_action :authenticate_user!
  def index
    burndown = Burndown.where("'#{Date.today}' between date_start AND date_end").first
    score = burndown.score_by_day
    @series = [{ name: 'Planejado', data: score }]
    @options = { title: "SPRINT #{burndown.sprint}", theme: 'rainbow' }
  end
end
