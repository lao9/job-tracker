require 'rails_helper'

describe "User sees job analytics dashboard" do
  before :each do
    # @company1 = create(:company)
    # @job1, @job2, @job3 = create_list(:job, 3)
    # 5, 10, 15 = 10 # company 1
    # 15, 20, 25 = 20 # company 2
    # 25, 30, 35 = 30 # company 3
    # 35, 40, 45 = 40 # comapny 4
  end
  scenario "A user can review the count of jobs by level of interest" do
    job1, job2, job3 = create_list(:job, 3)
    job1.update(level_of_interest: 10)
    job2.update(level_of_interest: 10)
    job3.update(level_of_interest: 20)
    #
    # As a user
    # When I visit /dashboard
    visit '/dashboard'
    # within class .count_by_interest
    within(".count_by_interest") do
      within("tr") do
        # table headers : level of interest and count
        expect(page).to have_content("Level of Interest")
        expect(page).to have_content("Count")
      end
      # I expect to see a row with class of row_10 (for level of interest)
      within(".row_10") do
        # I expect see it has content of 10
        # I expect to see it has content of 2 for count
        expect(page).to have_content("10")
        expect(page).to have_content("2")
      end
      # I expect to see a row with class of row_20 (for level of interest)
      within(".row_20") do
        # I expect see it has content of 20
        # I expect to see it has content of 1 for count
        expect(page).to have_content("20")
        expect(page).to have_content("1")
      end
    end
  end
  xscenario "A user can view the top three companes ranked by average level of interest" do
    # The top three companies ranked by average level
    # of interest along with their respective average level
    # of interest.
    # @company1 = create(:company)
    # @job1, @job2, @job3 = create_list(:job, 3)
    # 5 15 = 10 # company 1
    # 15 25 = 20 # company 2
    # 25 35 = 30 # company 3
    # 35 45 = 40 # comapny 4
    company1, company2, company3, company4 = create_list(:company, 4)
    job1, job2, job3, job4, job5, job6, job7, job8 = create_list(:job, 8)
    job1.update(company: company1, level_of_interest: 5)
    job2.update(company: company1, level_of_interest: 15)
    job3.update(company: company2, level_of_interest: 15)
    job4.update(company: company2, level_of_interest: 25)
    job5.update(company: company3, level_of_interest: 25)
    job6.update(company: company3, level_of_interest: 35)
    job7.update(company: company4, level_of_interest: 35)
    job8.update(company: company4, level_of_interest: 45)
    # As a user
    # When I visit /dashboard
    visit '/dashboard'
    # within class .count_by_interest
    within(".top_three_by_average_interest") do
      # I expect to see a header for Top Three Companies:
      # I expect to see "Companies are ranked by average level of interest"
      expect(page).to have_content("Top Three Companies:")
      expect(page).to have_content("Companies are ranked by average level of interest.")
      expect(page).to have_content("1. #{company4.name}: 40")
      expect(page).to have_content("2. #{company3.name}: 30")
      expect(page).to have_content("3. #{company2.name}: 20")
      expect(page).to_not have_content("4. #{company1.name}: 10")
      # within(".average_40") do
      # end
      # within(".average_30") do
      # end
      # within(".average_20") do
      # end
    end
  end
  xscenario "A user can view count of jobs per location" do
    job1, job2, job3, job4, job5, job6 = create(:job, 6)
    job1.update(city: "Atlanta")
    job2.update(city: "Denver")
    job3.update(city: "New York")
    job4.update(city: "Atlanta")
    job5.update(city: "New York")
    job6.update(city: "New York")
    # A count of jobs by location with a link
    # to visit a page with jobs only in that location.
    # The url should be /jobs?location=Denver.
    # As a user
    # When I visit /dashboard
    visit '/dashboard'
    # within class .jobs_per_location
    within(".jobs_per_city") do
    # table headers : city and count
      within("tr") do
        # table headers : level of interest and count
        expect(page).to have_content("City")
        expect(page).to have_content("Count")
      end
    # I expect to see a row with class of row_id (New York)
    # I expect see it has a link for New York's job page
    # I expect to see it has content of 3
      within(".row_1") do
        # I expect see it has content of 10
        # I expect to see it has content of 2 for count
        expect(page).to have_link("New York")
        expect(page).to have_content("3")
      end
    # I expect to see a row with class of row_id (Atlanta)
    # I expect see it has a link for Atlanta's job's page
    # I expect to see it has content of 2
      within(".row_2") do
        # I expect see it has content of 10
        # I expect to see it has content of 2 for count
        expect(page).to have_link("Atlanta")
        expect(page).to have_content("2")
      end
      # I expect to see a row with class of row_id (Denver)
      # I expect see it has a link for Denver's job's page
      # I expect to see it has content of 1
      within(".row_3") do
        # I expect see it has content of 10
        # I expect to see it has content of 2 for count
        expect(page).to have_link("Denver")
        expect(page).to have_content("1")
      end
    end
  end
  xscenario "A user can click on links to filter by each location" do
    job1, job2, job3, job4, job5, job6 = create(:job, 6)
    job1.update(city: "Atlanta")
    job2.update(city: "Denver")
    job3.update(city: "New York")
    job4.update(city: "Atlanta")
    job5.update(city: "New York")
    job6.update(city: "New York")
    # When I visit /dashboard
    visit '/dashboard'
    # within class .jobs_per_location
    within(".jobs_per_city") do
      # within "Atlanta"
      # when I click on Atlanta
      within(".row_2") do
        # I am directed to the Atlanta's job page
        expect(current_path).to eq('/jobs?location=Atlanta')
        # I can see content for city Atlanta
        # and both job titles
        # I do not see content for Denver and/or New York
        expect(page).to have_content("Atlanta")
        expect(page).to have_content(job1.title)
        expect(page).to have_content(job4.title)

        expect(page).to_not have_content("Denver")
        expect(page).to_not have_content("New York")
      end
    end
  end
end
