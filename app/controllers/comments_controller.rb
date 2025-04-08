class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :show, :edit, :update, :destroy ]

  def show
    # This action renders the show view for a specific comment
    # The @post and @comment variables are already set by the before_action callbacks
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "Comment was successfully added."
    else
      redirect_to post_path(@post), alert: "Failed to add comment."
    end
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment

    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404", status: :not_found
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404", status: :not_found
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
