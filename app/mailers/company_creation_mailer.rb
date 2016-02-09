class CompanyCreationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  def company_creation_information(company_id)
    @company = Company.find(company_id)
    mail(to: 'admin@example.com', subject: 'The Company: "#{company.name}" has been created')
  end
end
