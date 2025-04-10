class ApplicationController < ActionController::Base
  # Bảo vệ khỏi CSRF attacks (Cross-Site Request Forgery)
  #  Với :null_session: nếu request sai token, Rails sẽ reset session về nil → dùng cho API (đăng nhập không qua form HTML).
  protect_from_forgery with: :null_session

  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found # record not_found thì gọi tới hàm record_not_found

  def after_sign_in_path_for(resource) # sau khi login thành công thì call tới hàm này
    # binding.pry
    if resource.has_role?(:admin)
      admin_posts_path
    else
      root_path
    end
  end

  private

  def handle_exception(e)
    # Log lỗi
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace.join("\n"))

    # Notify service monitoring
    Sentry.capture_exception(e) if Rails.env.production?

    # Render error page
    respond_to do |format|
      format.html { render "errors/500", status: 500 }
      format.json { render json: { error: "Internal Server Error" }, status: 500 }
    end
  end

  def handle_not_found(e)
    respond_to do |format|
      format.html { render "errors/404", status: :not_found }
      format.json { render json: { error: "Resource not found" }, status: :not_found }
    end
  end

  def handle_unauthorized(e)
    respond_to do |format|
      format.html do
        flash[:error] = "Bạn không có quyền thực hiện hành động này"
        redirect_to root_path
      end
      format.json { render json: { error: "Unauthorized" }, status: :forbidden }
    end
  end
end
