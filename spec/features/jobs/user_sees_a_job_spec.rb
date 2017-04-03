require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    job = create(:job)

    visit company_job_path(job.company, job)

    expect(page).to have_content(job.company.name)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
  end

  scenario "a user can view an existing comment for a specific job" do
    comment = create(:comment)

    visit company_job_path(comment.job.company, comment.job)

    expect(page).to have_content(comment.body)
  end

  scenario "a user can leave and view their comment for a specific job" do
    job = create(:job)
    comment = create(:comment)

    visit company_job_path(job.company, job)

    fill_in "comment[body]", with: comment.body

    click_on "Leave Comment"

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content(comment.body)
  end

end
