class PostsController < ApplicationController
  include ActionView::RecordIdentifier

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

    respond_to do |format|
      if @post.save
        flash[:notice] = "Post was successfully created."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        # Redirect to root path instead of the post
        format.html { redirect_to root_path, notice: "Post was successfully created." }
      else
        @categories = Category.all
        # Handle errors for turbo_stream format
        format.turbo_stream do
          flash.now[:alert] = @post.errors.full_messages.join(", ")
          render turbo_stream: [
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html do
          flash.now[:alert] = @post.errors.full_messages.join(", ")
          render :new
        end
      end
    end
  end

  def edit
    @categories = Category.all

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@post),
          partial: "posts/form",
          locals: { post: @post, categories: @categories }
        )
      end
      format.html
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:notice] = "Post was successfully updated."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(dom_id(@post), partial: "posts/post", locals: { post: @post }),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_to root_path, notice: "Post was successfully updated." }
      else
        @categories = Category.all
        # Handle errors for turbo_stream format
        format.turbo_stream do
          flash.now[:alert] = @post.errors.full_messages.join(", ")
          render turbo_stream: [
            turbo_stream.replace(dom_id(@post), partial: "posts/form", locals: { post: @post, categories: @categories }),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:notice] = "Post was successfully deleted."
        render turbo_stream: [
          turbo_stream.remove(dom_id(@post)),
          turbo_stream.replace("flash", partial: "shared/flash")
        ]
      end
      format.html { redirect_to root_path, notice: "Post was successfully deleted." }
    end
  rescue => e
    respond_to do |format|
      format.turbo_stream do
        flash[:alert] = "An error occurred while deleting the post: #{e.message}"
        render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash")
      end
      format.html { redirect_to root_path, alert: "An error occurred while deleting the post: #{e.message}" }
    end
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

  # Make sure to define authorize_post! method
  def authorize_post!
    unless current_user == @post.user || current_user.has_role?(:admin)
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
