# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :set_role
  validate :verify_rules

  def set_role
    self.role_name = 'observer' if role_name.blank?
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def admin?
    role_name == 'admin'
  end

  def observer?
    role_name == 'observer'
  end

  def verify_rules
    errors.add('Permissão', 'deve preencher uma permissão') if role_name.blank?
  end
end
