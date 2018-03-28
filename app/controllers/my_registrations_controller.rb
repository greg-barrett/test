class MyRegistrationsController < Devise::RegistrationsController

  def create
    super
    if @user.persisted?
      UserMailer.signup_email(@user).deliver_now
    end
  end

end
