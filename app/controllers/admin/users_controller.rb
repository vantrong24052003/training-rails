class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @posts = @user.posts
    @comments = @user.comments
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def update_role
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
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :username)
  end
end
