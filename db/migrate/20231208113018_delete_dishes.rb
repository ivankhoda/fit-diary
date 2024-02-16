class DeleteDishes < ActiveRecord::Migration[7.0]
  def change
    drop_table :dishes
  end
end
