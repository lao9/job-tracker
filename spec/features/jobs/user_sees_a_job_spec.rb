require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    job = create(:job)

    visit company_job_path(job.company, job)

    expect(page).to have_content(job.company.name)
    expect(page).to have_content(job.title)
    expect(page).to have_content(job.level_of_interest)
  end

  scenario "a user can view an existing comment for a specific job" do
    comment = create(:comment)

    visit company_job_path(comment.job.company, comment.job)

    expect(page).to have_content(comment.body)
  end

  scenario "a user can leave and view their comment for a specific job" do
    job = create(:job)
    comment = create(:comment)

    visit company_job_path(job.company, job)

    fill_in "comment[body]", with: comment.body

    click_on "Leave Comment"

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content(comment.body)
  end

  scenario "a user can see tags associated with specific job" do
    tag1, tag2 = create_list(:tag, 2)
    job1, job2 = create_list(:job, 2)

    JobTag.create(tag: tag1, job: job1)
    JobTag.create(tag: tag1, job: job2)
    JobTag.create(tag: tag2, job: job1)

    visit company_job_path(job1.company, job1)

    expect(page).to have_content("Tags:")
    expect(page).to have_link(tag1.title)
    expect(page).to have_link(tag2.title)
  end
  scenario "a user can see number of jobs associated with that tag" do
    # as a user when i visit a specific job page
    # i see the name of each of the tags associated with that job
    # and i see a count of how many jobs have each specific tag listed
    tag1, tag2 = create_list(:tag, 2)
    job1, job2 = create_list(:job, 2)

    JobTag.create(tag: tag1, job: job1)
    JobTag.create(tag: tag1, job: job2)
    JobTag.create(tag: tag2, job: job1)

    visit company_job_path(job1.company, job1)
    
    expect(page).to have_link("#{tag1.title} (2)")
    expect(page).to have_link("#{tag2.title} (1)")
  end

  scenario "a user can click on a tag to go to that tag's show page" do
    tag1, tag2 = create_list(:tag, 2)
    job1, job2 = create_list(:job, 2)

    JobTag.create(tag: tag1, job: job1)
    JobTag.create(tag: tag1, job: job2)
    JobTag.create(tag: tag2, job: job1)

    visit company_job_path(job1.company, job1)

    click_link tag1.title

    expect(current_path).to eq(tag_path(tag1))
  end

end


# tag1, tag2 = create_list(:tag, 2)
# job1, job2 = create_list(:job, 2)
#
# JobTag.create(tag: tag1, job: job1)
# JobTag.create(tag: tag1, job: job2)
# JobTag.create(tag: tag2, job: job1)

# tag1 => job1, job2  job1 => tag1, tag2
# tag2 => job1        job2 => tag1


# When I visit a job show page
# I expect to see the tags listed there

# When I am on the Jobs index,
# I also see each job's tags

# When I create a new job
# I can check off multiple tags with check boxes
# and press submit
# and I expect to see the tags listed for that job

# WHen I update an exisitng job
# I can check off multiple tags with checkboxes
# And uncheck an existing tag
# and press submit
# And I expect to see the new tags there
# I do not expect to see the old tags there
