class DashboardsController < ApplicationController
  before_action :set_dashboard, only: %i[ show edit update destroy ]

  def index
    @search = Dashboard.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @dashboards = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @dashboard
  end

  def new
    @dashboard = Dashboard.new
  end

  def edit
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)
    @dashboard.save!

    respond_to do |format|
      format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @dashboard.update!(dashboard_params)
    respond_to do |format|
      format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    def dashboard_params
      params.require(:dashboard).permit(:index)
    end
end
