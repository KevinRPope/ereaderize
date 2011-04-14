ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'gmail.com',
  :authentication => :plain,
  :user_name => 'articles@ereaderize.com',
  :password => "sf53DfR3tGG"
}
if ENV["RAILS_ENV"] == 'development'
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
elsif ENV["RAILS_ENV"] == 'production'
  ActionMailer::Base.default_url_options[:host] = "ereaderize.com"
end
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.raise_delivery_errors = true