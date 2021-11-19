# frozen_string_literal: true

# Migration
class ChangeFieldsForUserTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :role_name, :permission
    add_column :users, :role, :string, default: 'observer'
    add_column :users, :socials, :json, default: {}
    add_column :users, :nickname, :string
    add_column :users, :start_in, :date
  end
end
