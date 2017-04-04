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
    # Assuming a few jobs in different cities exist
    # As a user
    # When I visit jobs location = Denver
    # I only see the job title and city for the job in Denver
    expect(page).to have_content(@job1.title)
    expect(page).to have_content(@job1.city)
    expect(page).to_not have_content(@job2.city)
    expect(page).to_not have_content(@job3.city)
    # I do not see the content for the  city for the jobs in New York and Atlanta
  end

  xscenario "a user can enter the city they want to filter by in a form from jobs index" do
    visit '/jobs'
    # Assuming a few jobs in different cities exist
    # As a user
    # When I visit any of the jobs page
    fill_in 'filter[city]', with "Denver"
    # and I fill in "Denver"
    click_on "Filter By City"
    # and I click on Filter By City
    expect(current_path).to eq('jobs?location=Denver')
    # I am redirected to '/jobs?location=Denver'
    expect(page).to have_content(@job1.title)
    expect(page).to have_content(@job1.city)
    expect(page).to_not have_content(@job2.city)
    expect(page).to_not have_content(@job3.city)
    # and I only see the job title and city for the job in Denver
    # I do not see the content for the  city for the jobs in New York and Atlanta
  end

  xscenario "a user can enter a partial for the city they want to filter by in a form from jobs index" do
    visit '/jobs'
    # Assuming a few jobs in different cities exist
    # As a user
    # When I visit any of the jobs page
    fill_in 'filter[city]', with "New"
    # and I fill in "Denver"
    # and I click on Filter By City
    # I am redirected to '/jobs?location=Denver'
    click_on "Filter By City"
    # and I click on Filter By City
    expect(current_path).to eq('jobs?location=New')
    # I am redirected to '/jobs?location=Denver'
    expect(page).to have_content(@job2.title)
    expect(page).to have_content(@job2.city)
    expect(page).to_not have_content(@job1.city)
    expect(page).to_not have_content(@job3.city)
    # and I only see the job title and city for the job in Denver
    # I do not see the content for the  city for the jobs in New York and Atlanta
  end

  xscenario "a user can enter a city they want to filter by in a form from jobs index with a sort param in place" do
    visit '/jobs?sort=interest'
    # Assuming a few jobs in different cities exist
    # As a user
    fill_in 'filter[city]', with "Denver"
    # and I fill in "Denver"
    click_on "Filter By City"
    # and I click on Filter By City
    expect(current_path).to eq('jobs?location=Denver')
    # I am redirected to '/jobs?location=Denver'
    expect(page).to have_content(@job1.title)
    expect(page).to have_content(@job1.city)
    expect(page).to_not have_content(@job2.city)
    expect(page).to_not have_content(@job3.city)
    # When I visit any of the jobs page
    # and I fill in "Denver"
    # and I click on Filter By City
    # I am redirected to '/jobs?location=Denver'
    # and I only see the job title and city for the job in Denver
    # I do not see the content for the  city for the jobs in New York and Atlanta
  end

end
