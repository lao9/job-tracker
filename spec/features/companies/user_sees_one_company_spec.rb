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
  scenario "a user sees existing contact information" do
    contact = create(:contact)

    visit company_path(contact.company)

    expect(page).to have_content(contact.name)
    expect(page).to have_content(contact.position)
    expect(page).to have_content(contact.email)
  end
  scenario "a user can add and view new contact information" do
    # When the user visits the page for a specific Company, in addition to information about the job there is a form that allows them to enter a Contact for that Company (e.g. “Penelope Santorini”, “Hiring Manager”, “penelope@wooo.com”).
    contact = build(:contact)
    expect(Contact.count).to eq(0)
    company = create(:company)
    # As a user
    # When I visit a company show page
    visit company_path(company)
    # And I fill in contact name
    fill_in 'contact[name]', with: contact.name
    # And I fill in contact position
    fill_in 'contact[position]', with: contact.position
    # And I fill in contact email
    fill_in 'contact[email]', with: contact.email
    # And click "Create New Contact"
    click_on 'Create New Contact'
    # I expect to be directed to the company show page
    expect(current_path).to eq(company_jobs_path(company))
    # I expect to see the contact's name
    expect(page).to have_content(contact.name)
    # I expect to see the contact's position
    expect(page).to have_content(contact.position)
    # And I expect to see the contact's email
    expect(page).to have_content(contact.email)
  end
end
