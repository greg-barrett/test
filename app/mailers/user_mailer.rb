class UserMailer < ApplicationMailer
  default from: 'welcome@fakebook.com'

  def signup_email(user)
    @user = user
    @url  = 'https://immense-tundra-82363.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Sign-up was successful')
  end
end
