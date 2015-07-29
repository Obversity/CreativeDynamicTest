class AddIndexToProducts < ActiveRecord::Migration
  def change
    add_index :products, :product_id, unique:true
  end
end
