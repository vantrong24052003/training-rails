class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    # The @post variable is already set by the before_action
  end

  def new
    @post = Post.new
    @categories = Category.all
    @users = User.all
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: "Post was successfully created."
    else
      @categories = Category.all
      @users = User.all
      render :new
    end
  end

  def edit
    @categories = Category.all
    @users = User.all
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post was successfully updated."
    else
      @categories = Category.all
      @users = User.all
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :category_id, :user_id)
  end
end
