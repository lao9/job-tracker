require 'rails_helper'

RSpec.feature "User sees a single category" do
  scenario "user can view a single category from category index" do
    category = create(:category)

    visit categories_path

    within(".category_#{category.id}") do
      click_link category.title
    end

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(category.title)
  end

  scenario "user can view a single category from job show page" do
    category = create(:category)
    job = create(:job)
    job.update(category: category)

    visit company_job_path(job.company, job)

    click_link category.title

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(category.title)
  end
  scenario "user can view all jobs associated with single category" do
    category = create(:category)
    job1, job2 = create_list(:job, 2)
    job1.update(category: category)
    job2.update(category: category)

    visit category_path(category)

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content(category.title)
    expect(page).to have_content(job1.title)
    expect(page).to have_content(job2.title)
  end
end
