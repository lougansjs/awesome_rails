# frozen_string_literal: true

# Rename in_use to status
class RenameInUseToStatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :burndowns, :in_use, :status
  end
end
