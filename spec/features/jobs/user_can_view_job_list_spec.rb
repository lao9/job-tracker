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
    visit '/jobs?sort=location'

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

  scenario "a user can click on the job's company" do
    visit '/jobs'

    within("#job_1") do
      click_link @job1.company.name
    end

    expect(current_path).to eq(company_jobs_path(@job1.company))
    expect(page).to have_content(@job1.company.name)
  end

  scenario "a user can click on the job's category" do
    visit '/jobs?sort=location'

    within("#job_3") do
      click_link @job2.category.title
    end

    expect(current_path).to eq(category_path(@job2.category))
    expect(page).to have_content(@job2.category.title)
  end

  scenario "a user can see all jobs sorted by level of interest" do
    @job1.update(level_of_interest: 10)
    @job2.update(level_of_interest: 20)
    @job3.update(level_of_interest: 30)

    visit '/jobs?sort=interest'

    within("#job_1") do
      expect(page).to have_content(@job3.title)
      expect(page).to have_content(@job3.level_of_interest)
    end

    within("#job_2") do
      expect(page).to have_content(@job2.title)
      expect(page).to have_content(@job2.level_of_interest)
    end

    within("#job_3") do
      expect(page).to have_content(@job1.title)
      expect(page).to have_content(@job1.level_of_interest)
    end
  end

  scenario "a user can see all jobs filtered by one particular city of interest" do
    visit 'jobs?location=Denver'

    expect(page).to have_content(@job1.title)
    expect(page).to have_content(@job1.city)
    expect(page).to_not have_content(@job2.city)
    expect(page).to_not have_content(@job3.city)
  end

  scenario "a user can enter the city they want to filter by in a form" do
    visit '/jobs'

    fill_in "Filter By A City:", with: "Denver"

    click_on "Filter!"

    expect(page).to have_content(@job1.title)
    expect(page).to have_content(@job1.city)
    expect(page).to_not have_content(@job2.city)
    expect(page).to_not have_content(@job3.city)
  end

  scenario "a user can enter a partial for the city they want to filter by" do
    visit '/jobs'

    fill_in "Filter By A City:", with: "New"

    click_on "Filter!"

    expect(page).to have_content(@job2.title)
    expect(page).to have_content(@job2.city)
    expect(page).to_not have_content(@job1.city)
    expect(page).to_not have_content(@job3.city)
  end

  scenario "a user can clear their filter" do
    visit 'jobs?location=Denver'

    click_on "Clear Filters"

    expect(page).to have_content(@job1.title)
    expect(page).to have_content(@job2.title)
    expect(page).to have_content(@job3.title)
    expect(page).to have_content(@job1.city)
    expect(page).to have_content(@job2.city)
    expect(page).to have_content(@job3.city)
  end

  scenario "a user can filter from jobs index with a sort param in place" do
    visit '/jobs?sort=interest'

    fill_in "Filter By A City:", with: "Denver"

    click_on "Filter!"

    expect(page).to have_content(@job1.title)
    expect(page).to have_content(@job1.city)
    expect(page).to_not have_content(@job2.city)
    expect(page).to_not have_content(@job3.city)
  end

  scenario "a user can enter a city they want to filter by in a form from jobs index with: a sort param in place" do
    visit '/jobs?sort=interest'

    fill_in "Filter By A City:", with: "Butthead"

    click_on "Filter!"

    expect(page).to have_content("No Jobs Found for that City!")
    expect(page).to_not have_content(@job1.title)
    expect(page).to_not have_content(@job2.title)
    expect(page).to_not have_content(@job3.title)
    expect(page).to_not have_content(@job1.city)
    expect(page).to_not have_content(@job2.city)
    expect(page).to_not have_content(@job3.city)
  end

end
