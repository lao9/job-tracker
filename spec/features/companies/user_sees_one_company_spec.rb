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
  xscenario "a user sees existing contact information" do
    # When the user visits the page for a specific Company, in addition to information about the job there is a form that allows them to enter a Contact for that Company (e.g. “Penelope Santorini”, “Hiring Manager”, “penelope@wooo.com”).
    # Assuming contact information for a specific company already exists
    # As a user
    # When I visit a company show page
    # I can view that contact's name, position, and email
  end
  xscenario "a user can add and view new contact information" do
    # When the user visits the page for a specific Company, in addition to information about the job there is a form that allows them to enter a Contact for that Company (e.g. “Penelope Santorini”, “Hiring Manager”, “penelope@wooo.com”).
    # As a user
    # When I visit a company show page
    # And I fill in contact name
    # And I fill in contact position
    # And I fill in contact email
    # And click "Create New Contact"
    # I expect to be directed to the company show page
    # I expect to see the contact's name
    # I expect to see the contact's position
    # And I expect to see the contact's email
  end
end
