# frozen_string_literal: true

# Migration
class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.string :title
      t.integer :qa_points
      t.integer :dev_points

      t.timestamps
    end
  end
end
