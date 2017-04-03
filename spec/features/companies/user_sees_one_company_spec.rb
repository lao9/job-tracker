require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    company = Company.create!(name: "ESPN")
    company.jobs << create(:job)

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}/jobs")
    expect(page).to have_content("ESPN")
    expect(page).to have_content(company.jobs.last.title)
  end
  xscenario "a user sees the contact information" do
    # When the user visits the page for a specific Company, in addition to information about the job there is a form that allows them to enter a Contact for that Company (e.g. “Penelope Santorini”, “Hiring Manager”, “penelope@wooo.com”).
  end
end
