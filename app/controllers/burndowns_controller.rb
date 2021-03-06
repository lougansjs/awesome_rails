# frozen_string_literal: true

# Controller for Burndowns
class BurndownsController < ApplicationController
  include BurndownsHelper
  before_action :authenticate_user!

  def index
    date_current = Date.current.strftime('%Y-%m-%d')
    @burndown = Burndown.where("'#{date_current}' between date_start AND date_end").first
    planned = @burndown.planned_by_day
    activities = artia_svc.count_activities(@burndown.mapping_passed_days)
    executed = @burndown.executed_by_day(activities)
    @series = [{ name: 'Planejado', data: planned }, { name: 'Realizado', data: executed }]
    @options = { theme: 'rainbow' }
  end

  def new
    @burndowns = Burndown.all
    @burndown = Burndown.new
  end

  def create
    @burndown = Burndown.new(burndown_params)
    if @burndown.save
      redirect_to new_burndown_path
    else
      @burndowns = Burndown.all
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def destroy
    @burndown = Burndown.find(params[:id])
    if @burndown.burndown_in_use?
      flash[:alert] = "Burndown##{@burndown.sprint} está em uso"
      redirect_to new_burndown_path
    else
      @burndown.destroy
      redirect_to new_burndown_path
    end
  end

  def burndown_params
    params.require(:burndown).permit(:date_start, :date_end, :metascore, :sprint)
  end

  def artia_svc
    @artia_svc = ArtiaService.new
  end
end
