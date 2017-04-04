require 'rails_helper'

describe Tag do
  describe "validations" do
    it "is invalid without a title" do
      tag = Tag.new

      expect(tag).to_not be_valid
    end
    it "is valid with a title" do
      tag = create(:tag)

      expect(tag).to be_valid
    end
  end

  describe "attributes" do
    it "responds to title" do
      tag = create(:tag)

      expect(tag).to respond_to(:title)
    end
  end

  describe "relationships" do
    it "has many jobs" do
      tag = create(:tag)

      expect(tag).to respond_to(:jobs)

      job1, job2 = create_list(:job, 2)

      JobTag.create(tag: tag, job: job1)
      JobTag.create(tag: tag, job: job2)

      expect(tag.jobs.count).to eq(2)
      expect(tag.jobs).to eq([job1, job2])
    end
  end
end
