require 'rails_helper'

describe "User edits an existing job" do
  scenario "a user can edit a job" do
    job = create(:job)
    new_job_title = "Butthead"

    visit edit_company_job_path(job.company, job)

    fill_in "job_title", with: new_job_title
    click_on "Update Job"

    expect(current_path).to eq(company_job_path(job.company, job))
    expect(page).to have_content(new_job_title)
    expect(Job.last.title).to eq(new_job_title)
  end
end
