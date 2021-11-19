# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :set_role

  def set_role
    self.permission = 'observer' if permission.blank?
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def admin?
    permission == 'admin'
  end

  def observer?
    permission == 'observer'
  end
end
