class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [ :show, :edit, :update, :update_role ]

  def index
    begin
      @users = User.all
    rescue => e
      redirect_to admin_users_path, alert: "An error occurred while fetching users: #{e.message}"
    end
  end

  def show
    begin
      @posts = @user.posts
      @comments = @user.comments
    rescue => e
      redirect_to admin_users_path, alert: "An error occurred while fetching user's posts or comments: #{e.message}"
    end
  end

  def edit
    # You can add error handling here if necessary
  end

  def update
    begin
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User was successfully updated."
      else
        render :edit, alert: "Failed to update user: #{@user.errors.full_messages.join(', ')}"
      end
    rescue => e
      redirect_to edit_admin_user_path(@user), alert: "An error occurred while updating the user: #{e.message}"
    end
  end

  def update_role
    begin
      role = params[:role]

      if Role::VALID_ROLES.include?(role.to_sym)
        @user.roles.each do |r|
          @user.remove_role(r.name)
        end

        @user.add_role(role)
        redirect_to admin_users_path, notice: "User's role was updated to #{role}."
      else
        redirect_to admin_users_path, alert: "Invalid role specified."
      end
    rescue => e
      redirect_to admin_users_path, alert: "An error occurred while updating the user's role: #{e.message}"
    end
  end

  private

  def set_user
      @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username)
  end
end
