require 'rails_helper'

describe Job do
  before :each do
    @category = create(:category)
  end
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver", category: @category)
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver", category: @category)
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80, category: @category)
        expect(job).to be_invalid
      end

      it "is invalid without a category" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 40, city: "Denver")
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title level of interest and category" do
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", category: @category)
        expect(job).to be_valid
      end
    end
  end

  describe "attributes" do
    it "has a title description level_of_interest and city" do
      job = Job.new

      expect(job).to respond_to(:title)
      expect(job).to respond_to(:description)
      expect(job).to respond_to(:level_of_interest)
      expect(job).to respond_to(:city)
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo", category: @category)
      expect(job).to respond_to(:company)
    end
    it "belongs to a category" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo", category: @category)
      expect(job).to respond_to(:category)
    end
    it "has many comments" do
      job = create(:job)
      comment1, comment2 = create_list(:comment, 2)
      comment1.update(job: job)
      comment2.update(job: job)

      expect(job).to respond_to(:comments)
      expect(job.comments.count).to eq(2)
      expect(job.comments).to eq([comment1, comment2])
    end
    it "has many tags" do
      job = create(:job)

      expect(job).to respond_to(:tags)

      tag1, tag2 = create_list(:tag, 2)

      JobTag.create(tag: tag1, job: job)
      JobTag.create(tag: tag2, job: job)

      expect(job.tags.count).to eq(2)
      expect(job.tags).to eq([tag1, tag2])
    end
  end
end
