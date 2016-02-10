class AdminCompanyCreationMailerJob < ActiveJob::Base
  queue_as :default

  def perform(company_id)
    company = Company.find(company_id)
    CompanyCreationMailer.company_creation_information(company).deliver_later
  end
end
