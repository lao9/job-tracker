class TagsController < ApplicationController

  def new
    @tag = Tag.new
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

  private

  def tag_params
    params.require(:tag).permit(:title)
  end

end
