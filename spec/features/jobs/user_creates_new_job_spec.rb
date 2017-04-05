require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create!(name: "ESPN")
    category = create(:category)

    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"
    select(category.title, :from => 'Category')

    click_button "Create"

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
  end

  scenario "a user cannot create a job without filling in category" do
    company = Company.create!(name: "ESPN")

    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(page).to have_content("Category can't be blank")
    expect(Job.count).to eq(0)
  end

  scenario "a user can add tags when creating new job" do
    company = create(:company)
    category = create(:category)
    tag1, tag2 = create_list(:tag, 2)

    visit new_company_job_path(company)

    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"
    check("tag-#{tag1.id}")
    check("tag-#{tag2.id}")
    select(category.title, :from => 'Category')

    click_button "Create"

    expect(Job.last.tags.count).to eq(2)
    expect(Job.last.tags).to eq([tag1, tag2])
    expect(current_path).to eq(company_job_path(company, Job.last))
    expect(page).to have_content("Tags:")
    expect(page).to have_link(tag1.title)
    expect(page).to have_link(tag2.title)
  end
end
