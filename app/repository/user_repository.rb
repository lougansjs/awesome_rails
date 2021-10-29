# frozen_string_literal: true

# UserRepository
class UserRepository
  def initialize
    @model = User
  end

  def observer_users
    @model.where(role_name: 'observer')
  end

  def admin_users
    @model.where(role_name: 'admin')
  end
end
