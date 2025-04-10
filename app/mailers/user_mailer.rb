class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @token = params[:token]
    @confirm_link = "#{root_url}confirm_email?token=#{@token}"

    mail(to: @user.email, subject: 'Welcome! Confirm your email')
  end

  def reset_password_email
    # gửi email khôi phục mật khẩu
  end

  def newsletter_email
    # gửi email bản tin
  end
end
