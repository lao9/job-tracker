require 'rails_helper'

describe "User sees all jobs" do
  before :each do
    @job1, @job2, @job3 = create_list(:job, 3)
    @job1.update(city: "Denver")
    @job2.update(city: "New York")
    @job3.update(city: "Atlanta")
  end
  scenario "a user sees all the jobs listed" do
    visit '/jobs'

    within("#job_1") do
      expect(page).to have_content(@job1.title)
      expect(page).to have_content(@job1.description)
      expect(page).to have_content("Denver")
      expect(page).to have_content(@job1.level_of_interest)
      expect(page).to have_link(@job1.company.name)
      expect(page).to have_link(@job1.category.title)
    end

    within("#job_2") do
      expect(page).to have_content(@job2.title)
      expect(page).to have_content(@job2.description)
      expect(page).to have_content("New York")
      expect(page).to have_content(@job2.level_of_interest)
      expect(page).to have_link(@job2.company.name)
      expect(page).to have_link(@job2.category.title)
    end

    within("#job_3") do
      expect(page).to have_content(@job3.title)
      expect(page).to have_content(@job3.description)
      expect(page).to have_content("Atlanta")
      expect(page).to have_content(@job3.level_of_interest)
      expect(page).to have_link(@job3.company.name)
      expect(page).to have_link(@job3.category.title)
    end
  end

  scenario "a user can see all jobs sorted by city" do
    # assuming a few jobs exist (maybe 3)
    # create job in cities: Denver, New York, Atlanta
    # as a user
    # when I visit /jobs?sort=location
    visit 'jobs?sort=location'
    # the first entry will be the job with the
    within("#job_1") do
      expect(page).to have_content(@job3.title)
      expect(page).to have_content(@job3.description)
      expect(page).to have_content("Atlanta")
      expect(page).to have_content(@job3.level_of_interest)
      expect(page).to have_link(@job3.company.name)
      expect(page).to have_link(@job3.category.title)
    end

    within("#job_2") do
      expect(page).to have_content(@job1.title)
      expect(page).to have_content(@job1.description)
      expect(page).to have_content("Denver")
      expect(page).to have_content(@job1.level_of_interest)
      expect(page).to have_link(@job1.company.name)
      expect(page).to have_link(@job1.category.title)
    end

    within("#job_3") do
      expect(page).to have_content(@job2.title)
      expect(page).to have_content(@job2.description)
      expect(page).to have_content("New York")
      expect(page).to have_content(@job2.level_of_interest)
      expect(page).to have_link(@job2.company.name)
      expect(page).to have_link(@job2.category.title)
    end

  end
  xscenario "a user can click on the job's company" do
    # assuming one job exists
    # as a user
    # when I visit /jobs
    visit '/jobs'
    # i can click on company
    within("#job_1") do
      click_link job1.company.name
    end
    # and will be redirected to the company's show page
    expect(current_path).to eq(company_jobs_path(job1.company))
    # and will have the content of the company's name
    expect(page).to have_content(job1.company.name)
  end
  xscenario "a user can click on the job's category" do
    # assuming one job exists
    # as a user
    # when I visit /jobs
    visit 'jobs?sort=location'
    # i can click on category
    within("#job_3") do
      click_link job3.company.name
    end
    # and will be redirected to the category's show page
    expect(current_path).to eq(company_jobs_path(job3.company))
    # and will have the content of the category's title
    expect(page).to have_content(job3.company.name)
  end
end
