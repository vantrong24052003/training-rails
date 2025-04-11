class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @posts = current_user.posts.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    begin
      if @user.update(profile_params)
        redirect_to profile_path, notice: "Profile updated successfully."
      else
        render :edit, alert: "Failed to update profile: #{@user.errors.full_messages.join(', ')}"
      end
    rescue => e
      redirect_to edit_profile_path, alert: "An error occurred while updating your profile: #{e.message}"
    end
  end

  private

  def profile_params
    params.require(:user).permit(:username, :avatar)
  end
end
