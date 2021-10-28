# frozen_string_literal: true

# Migration
class ChangeColumnStatusToDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default :burndowns, :status, from: nil, to: 0
  end
end
