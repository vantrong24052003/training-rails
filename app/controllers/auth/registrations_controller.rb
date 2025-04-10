class Auth::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params

  # POST /resource
  # Trong Devise::RegistrationsController, sau khi user được tạo thành công (resource.persisted?), Devise sẽ:

# Tạo confirmation_token

# Lưu confirmed_at: nil

# Gửi email xác nhận qua Devise::Mailer.confirmation_instructions
  def create
    super do |resource|
      if resource.persisted?
        resource.add_role(:user)
      end
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
