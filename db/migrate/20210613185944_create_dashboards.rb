class CreateDashboards < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboards do |t|
      t.string :index

      t.timestamps
    end
  end
end
