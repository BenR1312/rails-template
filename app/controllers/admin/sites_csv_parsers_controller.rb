class Admin::SitesCsvParsersController < Admin::BaseController

  def new
    authorize(SitesCsvParser)
  end

  def create
    authorize(SitesCsvParser)

    if params[:csv_parser][:file].blank? || !params[:csv_parser][:file].content_type.include?("csv")    
      flash[:alert] = "You must upload a CSV file"
    else
      flash.clear

      uploaded_file = params[:csv_parser][:file]
      @csv_parser = SitesCsvParser.new(uploaded_file.tempfile)
    end
  
    render :new
  end


end
