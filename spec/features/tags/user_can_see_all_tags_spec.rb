require 'rails_helper'

describe "User sees all tags" do
  it "user can see all tags" do

  end
end

# As a user
# When I visit the new_tag_path
# And I fill in a title
# And I press submit
# I am brought to the tag index page
# And I see my tag title there (which are links)

# Assuming we have a few tags created associated with a few jobs ...

# tag1, tag2 = create_list(:tag, 2)
# job1, job2 = create_list(:job, 2)
#
# JobTag.create(tag: tag1, job: job1)
# JobTag.create(tag: tag1, job: job2)
# JobTag.create(tag: tag2, job: job1)

# tag1 => job1, job2  job1 => tag1, tag2
# tag2 => job1        job2 => tag1

# As a user
# When I visit the tag index tags_path
# I see the title for all tags (which are links)

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
