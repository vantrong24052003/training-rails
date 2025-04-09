class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user] # Nhận data từ bên kia gửi qua
    mail(to: @user.email, subject: "Welcome!")
  end

  def reset_password_email
    # gửi email khôi phục mật khẩu
  end

  def newsletter_email
    # gửi email bản tin
  end
end
