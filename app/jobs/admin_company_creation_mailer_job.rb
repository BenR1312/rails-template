class AdminCompanyCreationMailerJob < ActiveJob::Base
  queue_as :default

  def perform(company_id)
    company = Company.find_by_id(company_id)
    
    if company.present?
      CompanyCreationMailer.company_creation_information(company).deliver_later
    end
  end
end
