class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :category
      t.string :product_name
      t.decimal :price

      t.timestamps null: false
    end
  end
end
