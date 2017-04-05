require 'rails_helper'

feature "User can view a single tag" do
  before :each do
    @tag1, @tag2 = create_list(:tag, 2)
    @job1, @job2 = create_list(:job, 2)

    JobTag.create(tag: @tag1, job: @job1)
    JobTag.create(tag: @tag1, job: @job2)
    JobTag.create(tag: @tag2, job: @job1)
  end

  scenario "user can click on title to view single tag" do
    visit tags_path

    within(".tag_1") do
      click_link(@tag1.title)
    end

    expect(current_path).to eq(tag_path(@tag1))
    expect(page).to have_content(@tag1.title)
  end

  scenario "user can view all jobs associated with tag" do
    visit tag_path(@tag1)

    within(".job_#{@job1.id}") do
      expect(page).to have_link(@job1.title)
    end
    within(".job_#{@job2.id}") do
      expect(page).to have_link(@job2.title)
    end
  end

  scenario "user can click on job link to go to job show page" do
    visit tag_path(@tag1)

    within(".job_#{@job1.id}") do
      click_link(@job1.title)
    end

    expect(current_path).to eq(company_job_path(@job1.company, @job1))
  end
end
