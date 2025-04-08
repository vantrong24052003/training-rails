class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @posts = Post.includes(:category, :user).published.order(created_at: :desc)
  end

  def show
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
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404", status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :category_id)
  end
end
