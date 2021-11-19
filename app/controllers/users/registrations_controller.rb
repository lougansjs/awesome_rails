# frozen_string_literal: true

# RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    @lerolero = utils_service.lerolero
  end

  def update
    @user = User.find(current_user.id)
    set_nickname_to_github
    if @user.update(user_params)
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(current_user.id)
    redirect_to permissions_path
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :first_name, :last_name, :nickname, :city, :state,
      :zip, :country, :photo, socials: [:github]
    )
  end

  def set_nickname_to_github
    if params[:user][:nickname].present?
      params[:user] = params[:user].merge(socials: { github: params[:user][:nickname] })
    end
  end

  def utils_service
    @utils_service ||= UtilsService.new
  end
end
