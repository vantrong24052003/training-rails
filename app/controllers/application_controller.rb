class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  protect_from_forgery with: :null_session
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def after_sign_in_path_for(resource)
    # binding.pry
    if resource.has_role?(:admin)
      admin_posts_path
    else
      root_path
    end
  end

  private

  def record_not_found
    render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
  end
end
