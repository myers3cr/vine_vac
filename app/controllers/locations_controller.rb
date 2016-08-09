class LocationsController < ApplicationController

  before_action :authenticate_member!
  before_action :set_action, only: [:new, :edit]
  before_action :set_location, only: [:edit, :update, :destroy]
  before_action :set_picture, only: [:new, :edit, :update]

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
    # binding.pry
    if @location.update(location_params)
      # add images if there are any
      if !params[:images].nil?
        params[:images].each { |image|
          @location.pictures.create(image: image)
        }
      end
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

  def set_action
    @action = params[:action].capitalize
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def set_picture
    if(@location)
      @picture_urls = []
      if @location.pictures.count > 0
        @location.pictures.each do |p|
          @picture_urls << p.image.url(:medium)
        end
      else
        @picture_urls = [ "missing-location.png" ]
      end
    else
      @picture_urls = [ "missing-location.png" ]
    end
  end

  def location_params
    params.require(:location).permit(:member_id, :loc_type, :name, :description, :address_1, :address_2,
      :city, :state, :postal_code, :images)
  end

end
