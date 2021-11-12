# frozen_string_literal: true

# Migration
class CreateApps < ActiveRecord::Migration[6.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.timestamps
    end
  end
end
