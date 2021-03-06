class UsersController < ApplicationController

# DO BEFORE METHODS 

  # User AUTHORIZATION
  # force :edit, :update pages through private sign_in_user method before executing methods/functions 
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]  

  # User AUTHENTICATION
  before_filter :correct_user,   only: [:edit, :update]

  # ADMIN, enable DESTROY only for admin
  before_filter :admin_user,     only: :destroy 

  
# GENERAL METHODS
  def show  # show users profile page , and posts from that user with count etc...
	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
	@users = User.paginate(page: params[:page])  # paginate index of info
	# @users = User.all  # gets all users, in array format, and puts them in @users object
  end

  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User destroy."
	redirect_to users_path
  end


# NEW USER
  def new
	@user = User.new
  end

  def create
	@user = User.new(params[:user])
	if @user.save
	  sign_in @user          # sign in after you signup to be a new user, sessions_helper.rb method
	  flash[:success] = "Welcome to the Sample App!"
	  redirect_to @user
	else
	  render 'new'
	end
  end 

# EDIT USER
  def edit
	# @user = User.find(params[:id])  # now run through PRIVATE correct_user method
  end

  def update
	# @user = User.find(params[:id])  # now down in PRIVATE correct_user method

	if @user.update_attributes(params[:user])
	  # hande a successful update.
	  flash[:success] = "profile updated"
	  sign_in @user		# all authentication methods in sessions_helper.rb
	  redirect_to @user
	
	else
	  render 'edit'
	end
  end

# PRIVATE METHODS
  # we can del signed_in_user (p457) because it is in SessionsHelper now, but this is a little different, so I'm keeping it for testing
  def signed_in_user
	store_location   # store location to return user to this pg when properly signed in
	redirect_to signin_path, notice: "Please sign in." unless signed_in?  # yellow notice bar
  end

  def correct_user
	@user = User.find(params[:id])
	redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
	redirect_to(root_path) unless current_user.admin?
  end

end
