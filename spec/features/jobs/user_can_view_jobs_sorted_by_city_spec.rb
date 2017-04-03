require 'rails_helper'

describe "User sees all jobs" do
  scenario "a user sees all the jobs listed" do
    # assuming a few jobs exist
    # create job in cities: Denver, New York, Atlanta
    # as a user
    # when i visit /jobs
    # i see the content for all my jobs
    # including title, description, city, company, category, level of interest
    # Denver should be first
    # New York should be second
    # Atlanta should be third
  end
  scenario "a user can click on the job's company" do
    # assuming one job exists
    # as a user
    # when I visit /jobs
    # i can click on company
    # and will be redirected to the company's show page
    # and will have the content of the company's name
  end
  scenario "a user can click on the job's category" do
    # assuming one job exists
    # as a user
    # when I visit /jobs
    # i can click on category
    # and will be redirected to the category's show page
    # and will have the content of the category's title
  end
  scenario "a user can see all jobs sorted by city" do
    # assuming a few jobs exist (maybe 3)
    # create job in cities: Denver, New York, Atlanta
    # as a user
    # when I visit /jobs?sort=location
    # the first entry will be the job with the
  end
end
