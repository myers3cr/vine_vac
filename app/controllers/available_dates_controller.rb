class AvailableDatesController < ApplicationController

  before_action :authenticate_member!
  before_action :set_action, only: [:new, :edit]
  before_action :set_member, only: [:new, :edit]
  before_action :set_location
  before_action :set_available_date, only: [:edit, :update, :destroy]

  def index
    @available_dates = @location.available_dates.order(:available_date)
    @future_dates = @location.available_dates.where("available_date >= ?", Date.today)
    respond_to do |format|
        format.html
        format.json
    end
  end

  def new
    @available_date = @location.available_dates.new
  end

  def edit
  end

  def update
    if @available_date.update_attributes(available_date_params)
      flash[:notice] = "Available date updated."
      redirect_to location_available_dates_path @location
    else
      render :edit
    end
  end

  def destroy
    @available_date.destroy
    flash[:notice] = "Available date deleted."
    redirect_to location_available_dates_path @location
  end

  def add
    first = params[:start_date].to_date
    last = params[:end_date].to_date
    price = params[:price].to_f
    (first..last).each do |d|
      a = @location.available_dates.new
      a.available_date = d 
      a.price = price
      a.status = :available
      a.save
    end
    # binding.pry
    flash[:notice] = "Available dates added."
    redirect_to location_available_dates_path @location
  end

private

  def available_date_params
    params.require(:available_date).permit(:available_date, :status, :price)
  end

  def set_action
    @action = params[:action].capitalize
  end

  def set_available_date
    @available_date = @location.available_dates.find(params[:id])
  end

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_member
    @member = current_member
  end

end
