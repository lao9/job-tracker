require 'rails_spec'

RSpec.feature "User sees a single category" do
  scenario "user can view a single category from category index" do
    # assuming a category exists
    # as a user
    # when I visit the category index page
    # and I click on a specific category
    # I can see that category's title
  end

  scenario "user can view a single category from job show page" do
    # assuming a category exists
    # and a job associated with that category exists
    # as a user
    # when I visit a job show page
    # and I click on the job's category
    # I can see that category's title
  end
  scenario "user can view all jobs associated with single category" do
    # assuming there are many jobs associated with a single category
    # as a user
    # when I vist a category show page
    # i see those jobs listed
    # pseudo
  end
end
