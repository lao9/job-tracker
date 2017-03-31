require 'rails_helper'

describe "User deletes an existing job" do
  scenario "a user can delete a job" do
    job = create(:job)

    visit company_jobs_path(job.company)

    within(".job_#{job.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("#{job.title} was successfully deleted!")
    expect(page).to_not have_content("#{job.description}")
  end
end
