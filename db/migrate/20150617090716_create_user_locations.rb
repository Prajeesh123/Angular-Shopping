class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.integer :user_id
      t.integer :loc_id

      t.timestamps
    end
  end
end
