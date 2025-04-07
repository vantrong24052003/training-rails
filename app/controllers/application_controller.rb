class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  protect_from_forgery with: :null_session
  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    # binding.pry
    if resource.has_role?(:admin)
      admin_posts_path
    else
      root_path
    end
  end
end
