class Auth::ConfirmationsController < ApplicationController
  def confirm_email
    token = params[:token]

    begin
      payload = JwtHelper.decode_token(token, Rails.application.credentials.dig(:jwt_secret_key))

      if payload["purpose"] == "email_confirmation"
        user = User.find_by(id: payload["sub"], email: payload["email"])

        if user
          user.update(confirmed_at: Time.current)
          flash[:notice] = "Email xác nhận thành công!"
        else
          flash[:alert] = "Không tìm thấy người dùng."
        end
      else
        flash[:alert] = "Token không hợp lệ."
      end
    rescue JWT::ExpiredSignature
      flash[:alert] = "Token đã hết hạn."
    rescue => e
      Rails.logger.error "Email confirmation failed: #{e.message}"
      flash[:alert] = "Xác nhận thất bại."
    end

    redirect_to root_path
  end
end
