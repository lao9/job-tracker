class List::JobsController < ApplicationController

  def index
    if params[:sort] == "location"
      @jobs = Job.order(:city)
    elsif params[:sort] == "interest"
      @jobs = Job.order(level_of_interest: :desc)
    elsif params[:location]
      @jobs = Job.where("city LIKE ?", "%#{params[:location]}%")
    elsif params[:q]
      redirect_to "/jobs?location=#{params[:q]}"
    else
      @jobs = Job.all
    end
  end

end
