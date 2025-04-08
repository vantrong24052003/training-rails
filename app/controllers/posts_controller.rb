class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @posts = Post.includes(:category, :user).published.order(created_at: :desc)
      @posts.limit(1).offset(2)
  end

  def show
    # binding.pry
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
    @categories = Category.all
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      @categories = Category.all
      render :new
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to new_post_path, alert: "Post creation failed: #{e.message}"
  rescue => e
    redirect_to new_post_path, alert: "An unexpected error occurred: #{e.message}"
  end

  def edit
    authorize @post
    @categories = Category.all
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      @categories = Category.all
      render :edit
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_post_path(@post), alert: "Post update failed: #{e.message}"
  rescue => e
    redirect_to edit_post_path(@post), alert: "An unexpected error occurred: #{e.message}"
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  rescue => e
    redirect_to posts_path, alert: "An error occurred while deleting the post: #{e.message}"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :category_id)
  end
end
