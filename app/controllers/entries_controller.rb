class EntriesController < ApplicationController

  before_action :require_login, :except => [:index, :show]

  def new
    if @current_user.nil?
      flash["notice"] = "YOU SHALL NOT PASS! Please login first"
      redirect_to "/login"
    end
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]

    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

 

end
