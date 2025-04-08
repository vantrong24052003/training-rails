class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  private

  def authorize_admin
    if current_user.has_role?(:user)
      redirect_to root_path, alert: "You are not authorized to access this section."
    end
  end
end
