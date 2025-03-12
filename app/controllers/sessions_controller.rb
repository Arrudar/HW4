class SessionsController < ApplicationController
  def new
  end

  def create
    
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        # Login the user
        session["user_id"] = @user["id"]
        flash["notice"] = "WELCOME! You've logged in."
        redirect_to "/places"
      else
        flash["notice"] = "NOPE! Unsuccessful login."
        redirect_to "/login"
      end

    else
      flash["notice"] = "NOPE! Unsuccessful login."
      redirect_to "/login"
    end

  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye fella!"
    redirect_to "/login"

  end
end
  