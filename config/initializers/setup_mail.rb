ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'mail.searchworld.com.au',
  :port           => 25,
  :user_name      => "webfirmsales",
  :password       => "webfirmsales00",
  :authentication => :plain,
  :domain         => "corp.cbm.net"
}