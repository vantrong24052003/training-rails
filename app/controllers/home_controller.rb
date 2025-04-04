class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # if current_user.has_role?(:admin)
    #   puts "Người dùng là admin"
    # else
    #  puts "Người dùng không phải là admin"
    # end
  end
end
