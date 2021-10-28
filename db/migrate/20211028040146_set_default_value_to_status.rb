# frozen_string_literal: true

# Migration
class SetDefaultValueToStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default :burndowns, :status, 0
  end
end
