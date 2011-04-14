class SessionsController < ApplicationController

  def create
#    raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.find_by_email(auth["extra"]["user_hash"]["email"])
    if user
      session[:user_id] = user.id
      if user.ereader_email.blank?
        flash[:notice] = "Successfully logged in using #{auth["provider"]}.  Please supply your eReader email address so we can send your articles directly there!"
        redirect_to :controller => :users, :action => :ereader_edit, :id => user.id
      else
        flash[:notice] = "Successfully logged in using #{auth["provider"]}."
        redirect_to root_path
      end
    else
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id
      flash[:notice] = "Successfully signed up using #{auth["provider"]}.  Please supply your eReader email address so we can send your articles directly there!"
      redirect_to :controller => :users, :action => :ereader_edit, :id => user.id
    end
  end
  

end
