class AddStoreToUserLocations < ActiveRecord::Migration
  def change
    add_column :user_locations, :store, :string
  end
end
