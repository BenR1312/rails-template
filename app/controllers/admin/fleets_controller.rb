class Admin::FleetsController < Admin::BaseController

  def index
    authorize(Fleet)
    @fleet = Fleet.all
  end

  def new
    @fleet = Fleet.new
    authorize(@fleet)
  end

  def create
    @fleet = Fleet.new(fleet_params)
    authorize(@fleet)
    @fleet.save
      
    respond_with(@fleet, location: admin_fleets_path)
  end

  def edit
    @fleet = Fleet.find(params[:id])
    authorize(@fleet)
    respond_with(@site, location: admin_fleets_path)
  end

  def update
    @fleet = Fleet.find(params[:id])
    @fleet.assign_attributes(fleet_params)
    authorize(@fleet)

    @fleet.save
    respond_with(@fleet, location: admin_fleets_path)
  end

  def destroy
    @fleet = Fleet.find(params[:id])
    authorize(@fleet)
    @fleet.destroy
    respond_with(@fleet, location: admin_fleets_path)
  end

private

  def fleet_params
    params.require(:fleet).permit(:fleet_name, fleet_trucks_attributes: [:id, :truck_id, :status, :_destroy])
  end
end
