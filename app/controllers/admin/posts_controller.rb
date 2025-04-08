class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
paginates_per 25
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    # binding.pry
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
  rescue ActiveRecord::RecordInvalid => e
    @categories = Category.all
    @users = User.all
    flash.now[:alert] = "Post creation failed: #{e.message}"
    render :new
  rescue => e
    @categories = Category.all
    @users = User.all
    flash.now[:alert] = "An unexpected error occurred: #{e.message}"
    render :new
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
  rescue ActiveRecord::RecordInvalid => e
    @categories = Category.all
    @users = User.all
    flash.now[:alert] = "Post update failed: #{e.message}"
    render :edit
  rescue => e
    @categories = Category.all
    @users = User.all
    flash.now[:alert] = "An unexpected error occurred: #{e.message}"
    render :edit
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post was successfully deleted."
  rescue => e
    redirect_to admin_posts_path, alert: "An error occurred while deleting the post: #{e.message}"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :category_id, :user_id)
  end
end
