class OrderTransaction < ActiveRecord::Base
  belongs_to :order
  serialize :params
  
  def response=(response)
    success       = response.success?
    authorization = response.authorization
    message       = response.message
    params        = response.params
  rescue ActiveMerchant::ActiveMerchantError => e
    success       = false
    authorization = nil
    message       = e.message
    params        = {}
  end
end
