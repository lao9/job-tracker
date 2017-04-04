class List::JobsController < ApplicationController

  def index
    if params[:sort] == "location"
      @jobs = Job.order(:city)
    else
      @jobs = Job.all
    end
  end

end
