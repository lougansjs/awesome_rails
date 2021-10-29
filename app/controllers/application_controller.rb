# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include ForgeryProtection
  include SetPlatform
  before_action :validate_permissions, if: :blacklist_and_signed_in?

  def after_sign_out_path_for(_resource_or_scope)
    user_session_path
  end

  def validate_permissions
    redirect_to root_path unless permission_svc.allowed?(self.class)
  end

  def blacklist_and_signed_in?
    user_signed_in? && !permission_svc.blacklisted?(self.class)
  end

  def permission_svc
    @permission_svc ||= PermissionService.new(current_user)
  end
end
