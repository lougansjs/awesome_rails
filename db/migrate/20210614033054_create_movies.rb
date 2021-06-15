class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.integer :year
      t.string :direct_by
      t.integer :duration
      t.string :genre
      t.integer :created_by
      t.string :rating

      t.timestamps
    end
  end
end
