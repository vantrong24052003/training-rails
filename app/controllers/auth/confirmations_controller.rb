class Auth::ConfirmationsController < Devise::ConfirmationsController
  def new
    super
  end

def create
  super
  # self.resource = resource_class.send_confirmation_instructions(resource_params)

  # if resource.nil?
  #   flash[:alert] = "❌ Email đã được xác nhận, vui lòng đăng nhập."
  # elsif resource.errors.empty?
  #   flash[:notice] = "📨 Resend email successfully!"
  # else
  #   flash[:alert] = "❌ " + resource.errors.full_messages.join(', ')
  # end

  # render :new
end


def show
  self.resource = resource_class.confirm_by_token(params[:confirmation_token])

  message =
    if resource.errors.empty?
      resource.confirmed? ? "confirm_success" : "already_confirmed"
    else
      "invalid_token"
    end

  render :show, locals: { resource: resource, message: message }
end


  protected

  def after_confirmation_path_for(resource_name, resource)
    signed_in_root_path(resource)
  end
end
