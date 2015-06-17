class AddNameToUserLocations < ActiveRecord::Migration
  def change
    add_column :user_locations, :name, :string
  end
end
