class Admin::TrucksController < Admin::BaseController

  def index
    authorize(Truck)
    @truck = Truck.all
  end

  def new
    @truck = Truck.new
    authorize(@truck)
  end

  def create
    @truck = Truck.new(truck_params)
    authorize(@truck)
    @truck.save

    respond_with(@truck, location: admin_trucks_path)
  end

  private

    def truck_params
      params.require(:truck).permit(:registration, :truck_model_id, :driver_id, :scheduled_maintenance, site_ids: [])
    end

end
