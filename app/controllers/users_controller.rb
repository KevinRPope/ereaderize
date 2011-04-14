class UsersController < ApplicationController
  before_filter :authorize, :except => [:show, :new, :edit, :update, :create, :destroy, :confirm, :ereader_edit, :edit_password, :authorize]
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(session[:user_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    sql = ActiveRecord::Base.connection();
    @test = (sql.execute "SELECT UUID();").to_a
    @user.guid = @test[0]

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.account_inactive = true
    @user.save

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def confirm
    @user = User.find_by_guid(params[:id])
    @user.confirmed_opt_in = true
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "You've confirmed your user registration!  Right on!"
        format.html {redirect_to(:action => :show)}
      else
        flash[:notice] = "We've experienced a problem.  Please re-try the confirmation link."
        format.html {redirect_to(:action => :show)}
      end
    end
  end
  
  def edit_password
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def ereader_edit
    @user = User.find(session[:user_id])
  end
  
  protected
  
  def authorize
    unless @user.access_level == 1
      flash[:error] = "You are not an administrator"
      redirect_to(:controller => 'test', :action => 'index')
    end
  end
  
end
