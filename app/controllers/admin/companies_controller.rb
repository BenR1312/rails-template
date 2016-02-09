class Admin::CompaniesController < Admin::BaseController

  def index
    authorize(Company)
    @company = Company.all
  end

  def new
    @company = Company.new
    authorize(@company)
  end

  def create
    @company = Company.new(company_params)
    authorize(@company)
    if @company.save
      AdminCompanyCreationMailerJob.set(wait_until: 1.day.from_now).perform_later(@company.id)
    end

    respond_with(@company, location: admin_companies_path)
  end

  def edit
    @company = Company.find(params[:id])
    authorize(@company)

    respond_with(@company, location: admin_companies_path)
  end

  def update
    @company = Company.find(params[:id])
    @company.assign_attributes(company_params)
    authorize(@company)

    @company.save
    respond_with(@company, location: admin_companies_path)
  end

  def destroy
    @company = Company.find(params[:id])
    authorize(@company)
    @company.destroy
    respond_with(@company, location: admin_companies_path)
  end

private

  def company_params
    params.require(:company).permit(:name, :country, :slogan, :banner_image, :logo, sponsors_attributes: [:id, :company_id, :name, :logo, :description, :_destroy] )
  end

end
