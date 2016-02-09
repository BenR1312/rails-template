class AdminCompanyCreationMailerJob < ActiveJob::Base
  queue_as :default

  def perform(*company_id)
    CompanyCreationMailer.company_creation_information(company_id).deliver_later
  end

end
