class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def index
    begin
      @comments = Comment.order(created_at: :desc)
    rescue => e
      redirect_to admin_comments_path, alert: "An error occurred while fetching comments: #{e.message}"
    end
  end

  def show
  end

  def edit
  end

  def update
    begin
      if @comment.update(comment_params)
        redirect_to admin_comments_path, notice: "Comment was successfully updated."
      else
        render :edit, alert: "Failed to update comment: #{@comment.errors.full_messages.join(', ')}"
      end
    rescue => e
      redirect_to edit_admin_comment_path(@comment), alert: "An error occurred while updating the comment: #{e.message}"
    end
  end

  def destroy
    begin
      if @comment.destroy
        redirect_to admin_comments_path, notice: "Comment was successfully deleted."
      else
        redirect_to admin_comments_path, alert: "Failed to delete comment."
      end
    rescue => e
      redirect_to admin_comments_path, alert: "An error occurred while deleting the comment: #{e.message}"
    end
  end

  private

  def set_comment
      @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
