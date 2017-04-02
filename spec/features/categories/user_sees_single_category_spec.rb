require 'rails_helper'

RSpec.feature "User sees a single category" do
  scenario "user can view a single category from category index" do
    # assuming a category exists
    category = create(:category)
    # as a user
    # when I visit the category index page
    visit categories_path
    # and I click on a specific category
    within(".category_#{category.id}") do
      click_link category.title
    end
    # I can see that category's title
    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(category.title)
  end

  xscenario "user can view a single category from job show page" do
    # assuming a category exists
    category = create(:category)
    # and a job associated with that category exists
    category.jobs.create(:job)

    job = category.jobs.last
    # as a user
    # when I visit a job show page
    visit company_job(job.company, job)
    # and I click on the job's category
    click_link category.title
    # I can see that category's title
    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(category.title)
  end
  xscenario "user can view all jobs associated with single category" do
    # assuming there are many jobs associated with a single category
    category = create(:category)
    job1, job2 = create_list(:job, 2)
    job1.update(category: category)
    job2.update(category: category)
    # as a user
    # when I vist a category show page
    visit category_path(category)
    # i see those jobs listed
    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(category.title)
    expect(page).to have_content(job1.title)
    expect(page).to have_content(job2.title)
    # pseudo
  end
end
