class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
    @location_set = !(@user.latitude.nil? || @user.longitude.nil?)
    @markers = build_markers(@user)
    render :show
  end

  def update_location
    current_user.update_attributes(latitude: params[:location][:latitude], longitude: params[:location][:longitude])
    render nothing: true
  end

  def update_address
    @user = current_user
    @coords = Geocoder.coordinates(params[:address])
    if !@coords.nil?
      @user.update_attributes(latitude: @coords[0], longitude: @coords[1])
    end
  end

  def edit_message
    @user = current_user
    @user.update_attributes(message: params[:message])
  end
end
