require 'rails_helper'

describe "User edits a tag" do
  it "user can edit an existing tag" do
    tag1, tag2 = create_list(:tag, 2)

    visit tags_path

    within(".tag_1") do
      click_link('Edit')
    end

    expect(current_path).to eq()
  end
end


# Assuming we have a few tags created associated with a few jobs ...

# tag1, tag2 = create_list(:tag, 2)
# job1, job2 = create_list(:job, 2)
#
# JobTag.create(tag: tag1, job: job1)
# JobTag.create(tag: tag1, job: job2)
# JobTag.create(tag: tag2, job: job1)

# tag1 => job1, job2  job1 => tag1, tag2
# tag2 => job1        job2 => tag1

# When I click on Edit
# And I fill in the title with a new title
# And I press submit
# I expect to be back on the tag index page
# And I see the new title
# the other tag title
# And I do not expect to see the old tag title

# When I click on Delete
# I expect to be back on the tag index page
# And I see the other tag title
# And I do not expect to see the old tag title

# When I click on a particular link
# I see the title of the tag
# and I see the links and titles for the jobs associated with

# When I visit the tag show page
# And I click on the job link
# I am brought to the job show page

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
