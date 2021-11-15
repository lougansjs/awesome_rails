# frozen_string_literal: true

# == ScoresController
class ScoresController < ApplicationController
  def index
    @score = Score.new
    @scores = Score.all
    @apps = App.all
  end

  def functionalities
    attributes = functionalities_params
    app = App.find(attributes[:id])
    render json: app.scores
  end

  def calculate
    score_service.calculate
  end

  private

  def functionalities_params
    params.permit(:id)
  end

  def calculate_params
    params.require(:anything).permit(:id, :role, :app, :functionality, :id_user)
  end

  def score_service
    @score_service ||= ScoreService.new(calculate_params)
  end
end
