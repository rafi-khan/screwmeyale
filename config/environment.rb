# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Screwyale::Application.initialize!

require 'casclient'
require 'casclient/frameworks/rails/filter'
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://secure.its.yale.edu/cas/",
  :username_session_key => :cas_user
)

credentials = YAML.load_file("#{Rails.root}/config/credentials.yml")
ENV['CAS_NETID'] = credentials['username']
ENV['CAS_PASS'] = credentials['password']
ENV['SENDGRID_NAME'] = credentials['sendgrid_name']
ENV['SENDGRID_PASS'] = credentials['sendgrid_password']


ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.sendgrid.net",
  :port => 25,
  :domain => "screwmeyale.com",
  :authentication => :plain,
  :user_name => ENV['SENDGRID_NAME'],
  :password => ENV['SENDGRID_PASS']
}

