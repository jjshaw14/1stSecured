ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 25,
  domain: 'fsadealer.com',
  authentication: :plain,
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD']
}
