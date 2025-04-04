class Admin::PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to admin_posts_path, notice: "Post was successfully created."
      else
        render :new
      end
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to admin_posts_path, notice: "Post was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to admin_posts_path, notice: "Post was successfully destroyed."
    end

    private

    def post_params
      params.require(:post).permit(:title, :content)
    end

    def require_admin
      unless current_user.has_role?(:admin)
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end
end
