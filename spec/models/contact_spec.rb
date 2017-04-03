require 'rails_helper'

describe Contact do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        contact = Contact.new(position: "Hiring Manager", email: "penelope@wooo.com")

        expect(contact).to be_invalid
      end
      it "is invalid without a position" do
        contact = Contact.new(name: "Penelope Santorini", email: "penelope@wooo.com")

        expect(contact).to be_invalid
      end
      it "is invalid without an email" do
        contact = Contact.new(name: "Penelope Santorini", position: "Hiring Manager")

        expect(contact).to be_invalid
      end
    end
    context "valid attributes" do
      it "is valid with a body" do
        contact = create(:contact)

        expect(contact).to be_valid
      end
    end
  end

  describe "attributes" do
    it "has a name position and email" do
      contact = Contact.new

      expect(contact).to respond_to(:name)
      expect(contact).to respond_to(:position)
      expect(contact).to respond_to(:email)
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      contact = create(:contact)
      company = create(:company)
      contact.update(company: company)

      expect(contact).to respond_to(:company)
      expect(contact.company).to eq(company)
    end
  end
end
