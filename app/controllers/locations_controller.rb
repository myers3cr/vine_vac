class LocationsController < ApplicationController

  before_action :authenticate_member!
  before_action :set_location, only: [:edit, :update, :destroy]


  def index
    @locations = current_member.locations
  end

  def new
    @location = current_member.locations.new
    authorize @location
  end

  def create
    @location = current_member.locations.new(location_params)
    authorize @location
    if @location.save
      redirect_to locations_path, notice: "Location added"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to locations_path, notice: 'Location updated.'
    else
        render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_path, notice: 'Location deleted.'
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:member_id, :loc_type, :name, :description, :address_1, :address_2,
      :city, :state, :postal_code)
  end

end
