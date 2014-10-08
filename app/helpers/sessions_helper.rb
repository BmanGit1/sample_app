module SessionsHelper

  def sign_in(user)
	cookies.permanent[:remember_token] = user.remember_token
	self.current_user = user
  end


# CURRENT USER AUTHORIZATION and AUTHENTICATION
  def current_user=(user) # assignment to current_user, method current_user= with arg as (user) 
	@current_user = user 
  end

  def current_user  # find current_user with remember_token ( current token or find )
	@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
	user == current_user
  end

  def signed_in_user    # to be used by microposts in case Poster is not signed in
	unless signed_in?
	  store_location  # will try to rediret user back here after they sign in
	  redirect_to signin_path, notice: "Please sign in."
  	end
  end


# SIGNIN / SIGNOUT
  def signed_in?
	!current_user.nil?  # says, current user is not nil? ie not logged in already 
		# true - current user is logged in,  false - no current user logged in
  end

  def sign_out
	self.current_user = nil
	cookies.delete(:remember_token)  # kill remember token in browser
  end

#FRIENDLY FORWARDING of users to their intended page
  def redirect_back_or(default)
	redirect_to(session[:return_to] || default)
	session.delete(:return_to)
  end

  def store_location
	session[:return_to] = request.fullpath
  end


end
