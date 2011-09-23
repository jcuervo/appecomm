class CreatePaymentNotifications < ActiveRecord::Migration
  def up
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :cart_id
      t.string :status
      t.string :transaction_id

      t.timestamps
    end
    
    add_column :carts, :purchased_at, :datetime
  end
  
  def down
    remove_column :carts, :purchased_at
    
    drop_table :payment_notifications
  end
end
