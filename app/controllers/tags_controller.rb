class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy, :show]

  def new
    @tag = Tag.new
  end

  def show
  end

  def index
    @tags = Tag.order(:title)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "You created the #{@tag.title} tag!"
      redirect_to tags_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @tag.update(tag_params)
    if @tag.save
      flash[:success] = "#{@tag.title} tag updated!"
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy

    flash[:sucess] = "#{@tag.title} was successfully deleted!"
    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:title)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

end
