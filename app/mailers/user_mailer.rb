class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @token = params[:token]
    @confirm_link = user_confirmation_url(
    confirmation_token: @token,
    host: Rails.application.config.action_mailer.default_url_options[:host]
  )


    mail(to: @user.email, subject: 'Welcome! Confirm your email') #send email chào mừng kèm nút confirm_link ở trong views/user_mailer/welcome_email.html.slim
  end

  def reset_password_email
    # gửi email khôi phục mật khẩu
  end

  def newsletter_email
    # gửi email bản tin
  end
end
