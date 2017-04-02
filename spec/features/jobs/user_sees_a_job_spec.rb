require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    job = create(:job)

    visit company_job_path(job.company, job)

    expect(page).to have_content(job.company.name)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
  end

  scenario "a user can view the comment form for a specific job" do
    #assuming a job exists
    # as a user
    # when i navigate to the job show page
    # and I fill in some comment in the body
    # then I click submit ("Submit Comment")
    # then I am back to the job show page
    # I can view my comment 
  end

end
