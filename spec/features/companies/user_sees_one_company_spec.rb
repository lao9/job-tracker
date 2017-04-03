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
    contact = build(:contact)
    expect(Contact.count).to eq(0)
    company = create(:company)

    visit company_path(company)

    fill_in 'contact[name]', with: contact.name
    fill_in 'contact[position]', with: contact.position
    fill_in 'contact[email]', with: contact.email

    click_on 'Create New Contact'

    expect(current_path).to eq(company_jobs_path(company))
    expect(page).to have_content(contact.name)
    expect(page).to have_content(contact.position)
    expect(page).to have_content(contact.email)
  end
end
