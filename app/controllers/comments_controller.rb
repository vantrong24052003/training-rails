class CommentsController < ApplicationController
  include ActionView::Helpers::TextHelper # Add this to use pluralize
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: [ :show, :edit, :update, :destroy ]
  before_action :check_comment_owner, only: [ :edit, :update, :destroy ]

  def show
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        flash[:notice] = "Comment was successfully added."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("post-comments", partial: "comments/comment", locals: { comment: @comment }),
            turbo_stream.replace("flash", partial: "shared/flash"),
            turbo_stream.update("comments-count", pluralize(@post.comments.count, "comment"))
          ]
        end
        format.html { redirect_to post_path(@post), notice: "Comment was successfully added." }
      else
        format.html { redirect_to post_path(@post), alert: "Failed to add comment: #{@comment.errors.full_messages.join(', ')}" }
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@comment),
          partial: "comments/form",
          locals: { comment: @comment, post: @post }
        )
      end
      format.html
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash[:notice] = "Comment was successfully updated."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(dom_id(@comment), partial: "comments/comment", locals: { comment: @comment }),
            turbo_stream.replace("flash", partial: "shared/flash")
          ]
        end
        format.html { redirect_to post_path(@post), notice: "Comment was successfully updated." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            dom_id(@comment),
            partial: "comments/form",
            locals: { comment: @comment, post: @post }
          )
        end
        format.html { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      flash[:notice] = "Comment was successfully deleted."
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(dom_id(@comment)),
          turbo_stream.replace("flash", partial: "shared/flash"),
          turbo_stream.update("comments-count", pluralize(@post.comments.count, "comment"))
        ]
      end
      format.html { redirect_to post_path(@post), notice: "Comment was successfully deleted." }
    end
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
