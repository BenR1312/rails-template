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

  def show
    authorize(@truck)
    @truck = Truck.find(params[:id])
  end

  def edit
    @truck = Truck.find(params[:id])
    authorize(@truck)
    @truck.save
    respond_with(@site, location: admin_trucks_path)
  end

  def update
    @truck = Truck.find(params[:id])

    if @truck.update(truck_params)
      respond_with(@truck, location: admin_trucks_path)
      authorize(@truck)
    else
      render 'edit'
    end
  end

  def destroy
    @truck = Truck.find(params[:id])
    authorize(@truck)
    @truck.destroy
    respond_with(@truck, location: admin_trucks_path)
  end

private

  def truck_params
    params.require(:truck).permit(:registration, :truck_model_id, :driver_id, :scheduled_maintenance, site_ids: [])
  end

end
