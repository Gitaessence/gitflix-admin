class UserMailer < ApplicationMailer
  default from: "aakashs209@gmail.com"

  def activate_account(user)
    @user = user
    mail(to: @user.email, subject: 'Email Activation Link')
  end
end
