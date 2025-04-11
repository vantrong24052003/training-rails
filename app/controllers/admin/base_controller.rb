# chỉ những controller kế thừa Admin::BaseController mới được kiểm tra authenticate_user! tự động.
class Admin::BaseController < ApplicationController
  # redirect new_user_session_path => đây là trang login được tạo ra từ devise_for :users
  before_action :authenticate_user! # chưa đăng nhập mà vào trang admin thì sẽ bị redirect tới trang login
  before_action :authorize_admin # đã đăng nhập thì kiểm tra xem có phải là admin không

  private

  def authorize_admin
    if current_user.has_role?(:user)
      redirect_to root_path, alert: "You are not authorized to access this section."
    end
  end
end
