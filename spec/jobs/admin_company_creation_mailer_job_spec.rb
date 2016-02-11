require 'rails_helper'

RSpec.describe AdminCompanyCreationMailerJob, type: :job do
  subject { AdminCompanyCreationMailerJob.new.perform(company.id) }
  let(:company) { FactoryGirl.create(:company) }

  it "ensures the enqueued job is set for the right time" do
    expect {
      AdminCompanyCreationMailerJob.set(wait_until: 1.day.from_now.change(hour: 8)).perform_later
    }.to have_enqueued_job.at(1.day.from_now.change(hour: 8))
  end

  it "ensures the enqueued count goes up by one" do
    expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  describe 'perform' do

    context "with an active Company" do
      it "sends company_creation_information from the mailer" do
        stub_mailer = double

        expect(CompanyCreationMailer).to receive(:company_creation_information).with(company).and_return(stub_mailer)

        expect(stub_mailer).to receive(:deliver_later)

        subject
      end
    end

    context "with a deleted Company" do
      before { company.destroy }

      it "does not send out an email" do
        expect(CompanyCreationMailer).not_to receive(:company_creation_information)
        subject
      end 
    end
  end
end