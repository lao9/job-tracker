require 'rails_helper'

# as a user when i visit a specific job page
# i see the name of each of the tags associated with that job
# and i see a count of how many jobs have each specific tag listed


# as a user
# when I visit a tags show page
# I should see a list of jobs for that tag
# I should also see a list of that job's tags
# Those tags should be in order of prevalence on our site
# (sorted in order of total job count for that tag)

RSpec.feature "beths crazy tag sorted page" do
  scenario "user sees job tag details for a specific tag" do
    tag1, tag2, tag3 = create_list(:tag, 3)
    job1, job2, job3 = create_list(:job, 3)

    JobTag.create(tag: tag1, job: job1)
    JobTag.create(tag: tag1, job: job2)
    JobTag.create(tag: tag2, job: job2)
    JobTag.create(tag: tag3, job: job2)
    JobTag.create(tag: tag3, job: job1)
    JobTag.create(tag: tag3, job: job3)

    visit tag_path(tag3)
    
    within("#job_rank_0") do
      expect(page).to have_link(job2.title)
      expect(page).to have_content("#{tag3.title} (3), #{tag1.title} (2), #{tag2.title} (1)")
    end

    within("#job_rank_1") do
      expect(page).to have_link(job1.title)
      expect(page).to have_content("#{tag3.title} (3), #{tag1.title} (2)")
    end

    within("#job_rank_2") do
      expect(page).to have_link(job3.title)
      expect(page).to have_content("#{tag3.title} (3)")
    end

  end

end


# visit tag3's show page

# job2
# tag3, tag1, tag2

# job1
# tag3, tag1

# job3
# tag 3
