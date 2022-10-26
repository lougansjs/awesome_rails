# frozen_string_literal: true

# Controller for Burndowns
class BurndownsController < ApplicationController
  include BurndownsHelper
  before_action :authenticate_user!

  def index
    @burndown = load_chart
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

  def close_sprint
    burndown = Burndown.find(params[:id])
    burndown.close_sprint
    burndown.save
    redirect_to burndowns_path
  end

  def load_chart
    burndown_svc.data
  end

  def burndown_params
    params.require(:burndown).permit(:date_start, :date_end, :metascore, :sprint)
  end

  def artia_svc
    @artia_svc = ArtiaService.new
  end

  def burndown_svc
    @burndown_svc = BurndownService.new
  end
end
