class Admin::SitesCsvParsersController < Admin::BaseController

  def new
    authorize(SitesCsvParser)
  end

  def create
    authorize(SitesCsvParser)
    
    if has_a_file && file_is_a_csv
      flash.clear
      uploaded_file = params[:csv_parser][:file]
      @csv_parser = SitesCsvParser.new(uploaded_file.tempfile)
    else
      flash[:alert] = "You must upload a CSV file"
    end
    render :new
  end
end

private

  def has_a_file
    params[:csv_parser].present? && params[:csv_parser][:file].present?
  end

  def file_is_a_csv
    params[:csv_parser][:file].respond_to?(:content_type) && params[:csv_parser][:file].content_type.include?("csv")
  end
