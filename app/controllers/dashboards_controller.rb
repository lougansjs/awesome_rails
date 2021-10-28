# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!
  def index
    @admins = user_service.admin_users(true)
  end

  def user_service
    @user_service = UserService.new
  end
end
