class List::JobsController < ApplicationController

  def index
    if params[:sort] == "location"
      @jobs = Job.order(:city)
    elsif params[:sort] == "interest"
      @jobs = Job.order(level_of_interest: :desc)
    else
      @jobs = Job.all
    end
  end

end
