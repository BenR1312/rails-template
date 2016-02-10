require "rails_helper"

RSpec.describe CompanyCreationMailer, type: :mailer do
  let!(:company)  { FactoryGirl.build(:company) }

  describe "#company_creation_information" do
    subject(:email) { CompanyCreationMailer.company_creation_information(company) }

    it "includes a description of the transfer in the subject line" do
      expect(email).to have_subject('The Company: "#{company.name}" has been created')
    end

    it "sends the email to the recipient" do
      expect(email).to deliver_to('admin@example.com')
    end
  end
end
