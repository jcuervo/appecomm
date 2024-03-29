class Order < ActiveRecord::Base
    
  belongs_to :cart
  has_many  :order_items
  
  attr_accessor :card_number, :card_verification, :ip_address, :first_name, :last_name, :card_type,
    :billing_name, :billing_email, :billing_phone, :billing_street, :billing_city, :billing_state, :billing_country, :billing_post
    
  validate :validate_card, :on => :create
  has_many :transactions, :class_name => "OrderTransaction"
  
  def purchase
    response = STANDARD_GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def price_in_cents
    (cart.total_price*100).round
  end


  private
  
  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => billing_name,
        :address1 => billing_street,
        :city     => billing_city,
        :state    => billing_state,
        :country  => billing_country,
        :zip      => billing_post
      }
    }
  end
  
  def validate_card
    if payment_type == "CreditCard"
      unless credit_card.valid?
        credit_card.errors.full_messages.each do |message|
          errors.add :base, message
        end
      end
    end  
  end
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
  
end
