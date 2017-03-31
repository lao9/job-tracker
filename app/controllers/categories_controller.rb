class CategoriesController < ApplicationController
  before_action :category_selector, only: [:show, :destroy, :edit, :update]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:success] = "You created the #{@category.title} category!"
      redirect_to categories_path
    else
      render :new
    end
  end

  def destroy
    @category.destroy

    flash[:success] = "#{@category.title} was successfully deleted!"
    redirect_to categories_path
  end

  def edit
  end

  def update
    @category.update(category_params)
    if @category.save
      flash[:success] = "#{@category.title} updated!"
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def show
  end

  private

  def category_selector
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title)
  end

end
