class CompanyCreationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  def company_creation_information(company)
    @company = company
    mail({
        subject: 'The Company: "#{company.name}" has been created',
        to: 'admin@example.com'
      })
  end
end
