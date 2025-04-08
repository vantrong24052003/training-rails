class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :show, :edit, :update, :destroy ]
  before_action :check_comment_owner, only: [ :edit, :update, :destroy ]

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
    # @comment is set by before_action
    # Owner check is performed by before_action
  end

  def update
    # @comment is set by before_action
    # Owner check is performed by before_action

    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    # @comment is set by before_action
    # Owner check is performed by before_action

    @comment.destroy
    redirect_to post_path(@post), notice: "Comment was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def check_comment_owner
    unless current_user == @comment.user || current_user.has_role?(:admin)
      redirect_to post_path(@post), alert: "You are not authorized to perform this action."
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
