# frozen_string_literal: true

# User Service
class UserService
  def observer_users(count = false)
    users = user_repo.observer_users
    users.size if count
  end

  def admin_users(count = false)
    users = user_repo.admin_users
    users.size if count
  end

  def user_repo
    @user_repo ||= UserRepository.new
  end
end
