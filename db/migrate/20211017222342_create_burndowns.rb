class CreateBurndowns < ActiveRecord::Migration[6.0]
  def change
    create_table :burndowns do |t|
      t.date :date_start
      t.date :date_end
      t.integer :sprint
      t.integer :metascore

      t.timestamps
    end
  end
end
