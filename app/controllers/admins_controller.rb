# frozen_string_literal: true

# Admin Controller
class AdminsController < ApplicationController
  before_action :authenticate_user!
  def index; end

  def permissions
    @users = User.all
    render 'permissions'
  end

  def update_permissions
    @user = User.find(params[:user][:user_id])
    if @user.update(permission: params[:role_permission])
      redirect_to permissions_path
    else
      @users = User.all
      respond_to do |format|
        format.html { render 'permissions' }
      end
    end
  end
end
