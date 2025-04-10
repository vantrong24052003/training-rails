class Auth::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params

  # POST /resource
  def create
    super do |resource|
      if resource.persisted?
        resource.add_role(:user)
        resource.skip_confirmation_notification! # Ngăn Devise gửi email xác nhận
        send_welcome_email(resource)
      end
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def send_welcome_email(user)
    begin
      token = JwtHelper.sign_token(
        { sub: user.id, email: user.email, purpose: 'email_confirmation' },
        Rails.application.credentials.dig(:jwt_secret_key)
      )
      UserMailer.with(user: user, token: token).welcome_email.deliver_later # Gửi email chào mừng và chuyển thông tin tới UserMailer
    rescue => e
      Rails.logger.error "Failed to send welcome email: #{e.message}"
    end
  end
end
