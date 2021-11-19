# frozen_string_literal: true

# Migration
class AddAppIdToScores < ActiveRecord::Migration[6.0]
  def change
    add_column :scores, :app_id, :integer
    add_foreign_key :scores, :apps, column: :app_id
  end
end
