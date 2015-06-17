class AddPriceToTest < ActiveRecord::Migration
  def change
    add_column :tests, :price, :float
  end
end
