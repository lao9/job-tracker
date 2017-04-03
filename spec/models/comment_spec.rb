require 'rails_helper'

describe Comment do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a body" do
        comment = Comment.new

        expect(comment).to be_invalid
      end
    end
    context "valid attributes" do
      it "is valid with a body" do
        comment = create(:comment)

        expect(comment).to be_valid
      end
    end
  end

  describe "attributes" do
    it "has a body created_at and updated_at timestamp" do
      comment = Comment.new

      expect(comment).to respond_to(:body)
      expect(comment).to respond_to(:created_at)
      expect(comment).to respond_to(:updated_at)
    end
  end

  describe "relationships" do
    it "belongs to a job" do
      comment = create(:comment)
      job = create(:job)
      comment.update(job: job)

      expect(comment).to respond_to(:job)
      expect(comment.job).to eq(job)
    end
  end
end
