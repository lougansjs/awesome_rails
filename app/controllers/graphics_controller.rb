# frozen_string_literal: true

class GraphicsController < ApplicationController
  include ApplicationHelper
  def index
    date1 = Date.today - 2.days
    date2 = ((date1 + 2.weeks) - 1.day)
    sprint = skip_weekends((date1..date2))
    metascore = 30
    @score = {}
    sprint.each_with_index do |day, index|
      @score[day] = metascore - (index * 3)
    end
    # activities = artia_service.filter_activities_artia
    @series = [{ name: 'Planejado', data: @score }]
    @options = { title: 'Users Growth', subtitle: 'Grouped Per Day', theme: 'rainbow' }
  end

  def artia_service
    ArtiaService.new
  end
end
