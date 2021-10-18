class AddRolenameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role_name, :string
  end
end
