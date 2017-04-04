require 'rails_helper'

describe "User sees job analytics dashboard" do
  scenario "A user can review the count of jobs by level of interest" do
    job1, job2, job3 = create_list(:job, 3)
    job1.update(level_of_interest: 10)
    job2.update(level_of_interest: 10)
    job3.update(level_of_interest: 20)

    visit '/dashboard'

    within(".count_by_interest") do
      within("tr.table-header") do
        expect(page).to have_content("Level of Interest")
        expect(page).to have_content("Count")
      end
      within(".row_10") do
        expect(page).to have_content("10")
        expect(page).to have_content("2")
      end
      within(".row_20") do
        expect(page).to have_content("20")
        expect(page).to have_content("1")
      end
    end
  end
  scenario "A user can view the top three companes ranked by average level of interest" do
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

    visit '/dashboard'

    within(".top_three_by_average_interest") do

      expect(page).to have_content("Top Three Companies:")
      expect(page).to have_content("Companies are ranked by average level of interest.")

      within(".average_40") do
        expect(page).to have_content("#{company4.name}: 40")
      end
      within(".average_30") do
        expect(page).to have_content("#{company3.name}: 30")
      end
      within(".average_20") do
        expect(page).to have_content("#{company2.name}: 20")
      end
      expect(page).to_not have_content("#{company1.name}: 10")
    end
  end
  scenario "A user can view count of jobs per location" do
    job1, job2, job3, job4, job5, job6 = create_list(:job, 6)
    job1.update(city: "Atlanta")
    job2.update(city: "Denver")
    job3.update(city: "New York")
    job4.update(city: "Atlanta")
    job5.update(city: "New York")
    job6.update(city: "New York")

    visit '/dashboard'

    within(".jobs_per_city") do
      within("tr.table-header") do
        expect(page).to have_content("City")
        expect(page).to have_content("Count")
      end
      within(".row_1") do
        expect(page).to have_link("New York")
        expect(page).to have_content("3")
      end
      within(".row_2") do
        expect(page).to have_link("Atlanta")
        expect(page).to have_content("2")
      end
      within(".row_3") do
        expect(page).to have_link("Denver")
        expect(page).to have_content("1")
      end
    end
  end
  scenario "A user can click on links to filter by each location" do
    job1, job2, job3, job4, job5, job6 = create_list(:job, 6)
    job1.update(city: "Atlanta")
    job2.update(city: "Denver")
    job3.update(city: "New York")
    job4.update(city: "Atlanta")
    job5.update(city: "New York")
    job6.update(city: "New York")

    visit '/dashboard'

    within(".jobs_per_city") do
      within(".row_2") do
        click_link "Atlanta"
      end
    end

    expect(page).to have_content("Atlanta")
    expect(page).to have_content(job1.title)
    expect(page).to have_content(job4.title)
    expect(page).to_not have_content("Denver")
    expect(page).to_not have_content("New York")
  end
end
