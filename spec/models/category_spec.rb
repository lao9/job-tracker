require 'rails_helper'

describe Category do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        category = Category.new
        expect(category).to be_invalid
      end
    end
    context "valid attributes" do
      it "is valid with a title" do
        category = create(:category)
        expect(category).to be_valid
      end
    end
    context "invalid with non-unique attributes" do
      it "is invalid without uniqueness" do
        category1 = Category.create(title: "Engineering")
        category2 = Category.new(title: category1.title)

        expect(category1).to be_valid
        expect(category2).to_not be_valid
      end
    end
    context "unique attributes" do
      it "is valid when unique" do
        category1, category2 = create_list(:category, 2)

        expect(category1).to be_valid
        expect(category2).to be_valid
      end
    end
  end

  describe "attributes" do
    it "has a title" do
      category = Category.new

      expect(category).to respond_to(:title)
    end
  end

  describe "relationship" do
    it "has many jobs" do
      category = create(:category)
      job1, job2 = create_list(:job, 2)
      job1.update(category: category)
      job2.update(category: category)

      expect(category).to respond_to(:jobs)
      expect(category.jobs.count).to eq(2)
      expect(category.jobs).to eq([job1, job2])
    end
  end
end
