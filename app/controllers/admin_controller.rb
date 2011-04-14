class AdminController < ApplicationController

  def login
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        flash[:notice] = "User #{user.email} logged in successfully"
        redirect_to(:action => 'index', :controller => 'test')
      else
        flash[:notice] = "Invalid email/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You've successfully logged out.  Come again."
    redirect_to(:action => 'index', :controller => 'test')
  end

  def register
    
  end

  def thank_you
    email = UserMailer.deliver_confirm(session[:user_id])
    puts EmailLog.log(email, 1) # 1 = automated contact
    flash[:notice] = 'Don\'t forget you\'ve set the email server to not send them due to lack of connectivity!'
    respond_to do |format|
      format.html
    end
    
  end
  
  protected
  
  def authorize
    unless @user.access_level == 1
      flash[:notice] = "You are not an administrator"
      redirect_to(:controller => 'test', :action => 'index')
    end
  end
end
