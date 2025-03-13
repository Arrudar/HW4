class PlacesController < ApplicationController
  
  before_action :require_login, :except => [:index, :show]
  
  def index
    if @current_user
      @places = Place.where({ "user_id" => @current_user["id"] })
    else
      @places = []  # Leave it empty
    end
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    
    # Only show if it belongs to current user
    if @place && @current_user && @place["user_id"] == @current_user["id"]
      @entries = Entry.where({ "place_id" => @place["id"] }).order("created_at DESC")
    else
      if @current_user
        flash["notice"] = "Not authorized to view this place"
      else
        flash["notice"] = "Please login first"
      end
      
      redirect_to "/places"
    
    end
  end

  def new
    if @current_user
      @place = Place.new
    else
      flash["notice"] = "Please login first"
      redirect_to "/login"
    end
  end

  def create
    if @current_user
      @place = Place.new
      @place["name"] = params["name"]
      @place["user_id"] = @current_user["id"]  # Link to the user that is using Tacosgram
      @place.save
      redirect_to "/places"
    else
      flash["notice"] = "Please login first"
      redirect_to "/login"
    end
  
  end


end
