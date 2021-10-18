# frozen_string_literal: true

# Admin Controller
class AdminsController < ApplicationController
  before_action :authenticate_user!
  def index; end
end
