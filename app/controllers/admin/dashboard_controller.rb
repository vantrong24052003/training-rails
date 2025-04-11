class Admin::DashboardController < Admin::BaseController
  def index
    @posts_count = Post.count
    @users_count = User.count
    @comments_count = Comment.count
    @categories_count = Category.count
    @recent_posts = Post.order(created_at: :desc).limit(5)
    @recent_users = User.order(created_at: :desc).limit(5)
  end
end
