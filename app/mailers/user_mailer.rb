class UserMailer < ApplicationMailer
  def welcome(user)
    mail to: user.email, subject: 'Welcome to 1st Secured Administrators!'
  end
end
