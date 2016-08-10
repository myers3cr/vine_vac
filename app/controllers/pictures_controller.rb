class PicturesController < ApplicationController

  before_action :authenticate_member!
  before_action :set_location
  before_action :set_picture, only: [:edit, :update]

  def index
    @pictures = @location.pictures
  end

  def edit
  end

  def update
    # binding.pry
    if @picture.update(picture_params)
      redirect_to location_pictures_path(@location), notice: 'Picture updated.'
    else
      render :edit
    end
  end

private

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_picture
     @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:picture_id, :caption)
  end

end
