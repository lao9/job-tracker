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
  end
end
