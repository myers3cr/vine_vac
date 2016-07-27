class LocationsController < ApplicationController

  before_action :authenticate_member!

  def index
    @locations = Location.where("member_id = ?", current_member)
  end

  def new
    @location = Location.new
    authorize @location
  end

  def create
    @location = Location.new(location_params)
    authorize @location
    @location.member_id = current_member.id
    if @location.save
      redirect_to locations_path, notice: "Location added"
    else
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to locations_path, notice: 'Location updated.'
    else
        render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_path, notice: 'Location deleted.'
  end

  private

  def location_params
    params.require(:location).permit(:member_id, :loc_type, :name, :description, :address_1, :address_2,
      :city, :state, :postal_code)
  end

end
