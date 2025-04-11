class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :load_dependencies, only: [ :new, :create, :edit, :update ]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: "Post was successfully created."
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post was successfully updated."
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to admin_posts_path, notice: "Post was successfully deleted."
    else
      redirect_to admin_posts_path, alert: "Failed to delete post."
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def load_dependencies
    @categories = Category.all
    @users = User.all
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :category_id, :user_id)
  end
end
