# frozen_string_literal: true

# Migration
class ChangeTypeColumnToInteger < ActiveRecord::Migration[6.0]
  def change
    remove_column :burndowns, :status
    add_column :burndowns, :status, :integer
    add_column :burndowns, :in_use, :boolean, default: false
  end
end
