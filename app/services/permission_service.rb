# frozen_string_literal: true

# Permission Service
class PermissionService
  IGNORE_CONTROLLERS = ['SessionsController'].freeze
  def initialize(user)
    @user = user
  end

  def allowed?(controller)
    return true if @user.admin?
    return true if @user.permission.nil?

    Roles['roles']['observer'].include?(controller.to_s) if @user.observer?
  end

  def blacklisted?(controller)
    IGNORE_CONTROLLERS.include?(controller.to_s)
  end
end
