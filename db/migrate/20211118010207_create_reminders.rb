# frozen_string_literal: true

# Create reminders table
class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.string :name
      t.string :message
      t.json :schedule, default: {}
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
