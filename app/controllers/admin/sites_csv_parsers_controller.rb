class Admin::SitesCsvParsersController < Admin::BaseController

  def new
    authorize(SitesCsvParser)
  end

  def create
    authorize(SitesCsvParser)

    if params[:file].blank? || !params[:file].content_type.include?("csv")    
      flash[:alert] = "You must upload a CSV file"
    else
      flash.clear
      @csv_parser = SitesCsvParser.new(params[:file])
    end
  
    render :new
  end


end
