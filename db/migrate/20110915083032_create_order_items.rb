class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :quantity, :default => 1
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
