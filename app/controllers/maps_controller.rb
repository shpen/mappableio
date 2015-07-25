class MapsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_map, except: [:new, :create]
  before_action :check_user_ownership, only: [:edit, :update, :destroy]

  def show
    @markers = build_markers @map.members
  end

  def new
    @map = Map.new
  end

  def create
    @map = current_user.maps.build(map_params)

    if @map.save
      redirect_to @map, flash: { success: "Map successfully created." }
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @map.update(map_params)
      redirect_to @map, flash: { success: "Map successfully updated." }
    else
      render :edit
    end
  end

  def destroy
    @map.destroy
    redirect_to root_url, flash: { success: 'Map was successfully destroyed.' }
  end

  def join
    if current_user.latitude.nil? || current_user.longitude.nil?
      redirect_to profile_path, flash: { danger: "You must set your location first." }
    else
      @map.members << current_user
      redirect_to @map, flash: { success: "Joined map." }
    end
  end

  def leave
    @map.members.delete current_user
    redirect_to @map, flash: { success: "Removed from map." }
  end

  private
    def set_map
      @map = Map.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:title, :description)
    end

    # Make sure user taking action is the owner
    def check_user_ownership
      if @map.user != current_user
        redirect_to(request.referrer || root_url, flash: { danger: 'You do not have permission to do that.' })
      end
    end
end