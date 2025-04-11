class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy, :report ]
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :authorize_post!, only: [ :edit, :update, :destroy ]

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

  if @post.save!
    redirect_to @post, notice: "Post was successfully created."
  else
    @categories = Category.all
    flash.now[:alert] = @post.errors.full_messages.join(", ")
    render :new
  end
  end


  def edit
    @categories = Category.all
  end

  def update
  if @post.update(post_params)
    redirect_to @post, notice: "Post was successfully updated."
  else
    @categories = Category.all
    render :edit
  end
  end


  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  rescue => e
    redirect_to posts_path, alert: "An error occurred while deleting the post: #{e.message}"
  end

def report
  @post = Post.find(params[:id])
  @reporter = current_user
  @author = @post.user

  # Gửi email cho tác giả bài viết (người bị report)
  UserMailer.with(user: @author, post: @post, reporter: @reporter)
            .reported_notification_email.deliver_later

  # Gửi email cho admin
  UserMailer.with(user: @author, post: @post, reporter: @reporter)
            .admin_report_notification_email.deliver_later

  redirect_to @post, notice: "Bài viết đã được report. Chúng tôi sẽ xem xét sớm!"
end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :category_id)
  end
end
