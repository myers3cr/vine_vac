class ProfilesController < ApplicationController

  def index
    @profile = current_member.profile
    if @profile.nil?
      redirect_to new_profile_path
    else
      redirect_to edit_profile_path(current_member.id)
    end
  end

  def new
    begin
      @profile = Profile.new      
    end
  end

  def edit
    @profile = current_member.profile
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.member_id = current_member.id
    if @profile.save
      redirect_to root_path, notice: "Profile updated successfully."
    else
      render action: "new"
    end
  end

  def update
    @profile = current_member.profile
    if @profile.update(profile_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      render action: "new"
    end   
  end
  
  def profile_params
    params.require(:profile).permit(:member_id, :first_name, :last_name, :address_1, :address_2,
      :city, :state, :postal_code )
  end

end
