class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_email
  
  def get_email
    if session[:user_id]
      @user = User.find(session[:user_id], :select => "email, name, access_level")
#    else
#      @user = User.find(0, :select => "email")
    end
  end
end
