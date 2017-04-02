require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    job = create(:job)

    visit company_job_path(job.company, job)

    expect(page).to have_content(job.company.name)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
  end

  xscenario "a user can view an existing comment for a specific job" do
    comment = comment(:create)

    visit company_job_path(comment.job.company, comment.job)

    expect(page).to have_content(comment.body)
  end

  xscenario "a user can leave and view their comment for a specific job" do
    job = create(:job)

    comment = create(:comment)
    #assuming a job exists
    # as a user
    # when i navigate to the job show page
    visit company_job_path(job.company, job)
    # and I fill in some comment in the body
    fill_in comment.body, with: comment.body

    # then I click submit ("Submit Comment")

    click_on "Leave Comment"

    # then I am back to the job show page

    expect(current_path).to eq(company_job_path(job.company, job))
    # I can view my comment
    expect(page).to have_content(comment.body)
  end

end
