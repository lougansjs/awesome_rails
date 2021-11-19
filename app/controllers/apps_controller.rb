# frozen_string_literal: true

# == AppsController
class AppsController < ApplicationController
  def index
    @apps = App.all
    @app = App.new
  end

  def new; end

  def create
    @app = App.new(apps_params)
    if @app.save
      redirect_to apps_path
    else
      @apps = App.all
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update; end

  def show; end

  def destroy
    app = Burndown.find(params[:id])
    app.destroy
    redirect_to apps_path
  end

  def apps_params
    params.require(:app).permit(:name)
  end
end
