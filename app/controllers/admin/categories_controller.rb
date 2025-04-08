class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [ :edit, :update, :destroy ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    begin
      if  Category.create(category_params)
        # flash[:notice] = "User created successfully" hoặc  notice: "Category was successfully created."
        redirect_to admin_categories_path, notice: "Category was successfully created."
      else
        redirect_to new_admin_category_path, alert: @category.errors.full_messages.join(", ")
      end
    rescue => e
      redirect_to new_admin_category_path, alert: e.message
    end
  end

  def edit
  end

  def update
    begin
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: "Category was successfully updated."
      else
        redirect_to edit_admin_category_path(@category), alert: @category.errors.full_messages.join(", ")
      end
    rescue => e
      redirect_to edit_admin_category_path(@category), alert: e.message
    end
  end

  def destroy
    begin
      if @category.destroy
        redirect_to admin_categories_path, notice: "Category was successfully deleted."
      else
        redirect_to admin_categories_path, alert: "Category could not be deleted."
      end
    rescue => e
      redirect_to admin_categories_path, alert: e.message
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
