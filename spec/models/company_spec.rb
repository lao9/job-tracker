require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "attributes" do
    it "has a name" do
      company = Company.new

      expect(company).to respond_to(:name)
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
    it "has many contacts" do
      company = create(:company)
      contact1, contact2 = create_list(:contact, 2)
      contact1.update(company: company)
      contact2.update(company: company)

      expect(company).to respond_to(:contacts)
      expect(company.contacts.count).to eq(2)
      expect(company.contacts).to eq([contact1, contact2])
    end
  end
end
