class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to admin_comments_path, notice: "Comment was successfully deleted."
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
