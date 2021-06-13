class ApplicationController < ActionController::Base
  include ForgeryProtection
  include SetPlatform

  def after_sign_out_path_for(resource_or_scope)
    user_session_path
  end
end
