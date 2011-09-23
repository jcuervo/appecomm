class AddBillingDataToOrders < ActiveRecord::Migration
  def up
    change_table :orders do |t|
      t.string :del_name, :del_street, :del_city, :del_state, :del_country, :del_post
      t.string :status, :payment_type, :transaction_id
      t.float  :total
      
      t.remove :card_type, :first_name, :last_name, :ip_address
    end
  end
  
  def down
    change_table :orders do |t|
      t.remove :del_name, :del_street, :del_city, :del_state, :del_country, :del_post,
        :status, :payment_type, :transaction_id,
        :total
        
      t.string :card_type, :first_name, :last_name, :ip_address
    end
  end
end