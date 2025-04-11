class Admin::CommentsController < Admin::BaseController
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def show
    # nếu bạn chưa dùng đến, có thể xóa luôn action này
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: "Comment was successfully updated."
    else
      flash.now[:alert] = @comment.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to admin_comments_path, notice: "Comment was successfully deleted."
    else
      redirect_to admin_comments_path, alert: "Failed to delete comment."
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id]) # nếu không tìm thấy thì ExceptionHandler lo luôn
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
