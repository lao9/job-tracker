class List::JobsController < ApplicationController

  def index
    @jobs = Job.all
  end

end
