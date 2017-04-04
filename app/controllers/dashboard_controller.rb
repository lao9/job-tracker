class DashboardController < ApplicationController

  def index
    @count_by_interest = Job.count_by_interest
    @top_three_by_average_interest = Job.top_three_by_average_interest
    @count_by_city = Job.count_by_city
  end

end
