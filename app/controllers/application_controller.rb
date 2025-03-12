class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    puts "------------------ code before every request ------------------"
    @current_user = User.find_by({ "id" => session["user_id"] })
  end

  def require_login
    if @current_user.nil?
      flash["notice"] = "Please login first"
      redirect_to "/login"
    end
  end
  
end
