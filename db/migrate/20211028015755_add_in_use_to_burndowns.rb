# frozen_string_literal: true

class AddInUseToBurndowns < ActiveRecord::Migration[6.0]
  def change
    add_column :burndowns, :in_use, :boolean, default: false
  end
end
