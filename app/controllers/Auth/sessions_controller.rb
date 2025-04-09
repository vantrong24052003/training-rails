class Auth::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)

    if resource&.confirmed?
      # Nếu đã xác nhận email → đăng nhập bình thường
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      # Nếu chưa xác nhận → từ chối đăng nhập
      flash[:alert] = "Vui lòng xác nhận email trước khi đăng nhập."
      redirect_to new_session_path(resource_name)
    end
  end
end
