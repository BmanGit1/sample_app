module SessionsHelper

  def sign_in(user)
	cookies.permanent[:remember_token] = user.remember_token
	self.current_user = user
  end

  def current_user=(user) # assignment to current_user, method current_user= with arg as (user) 
	@current_user = user 
  end

  def current_user  # find current_user with remember_token ( current token or find )
	@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
	!current_user.nil?  # says, current user is not nil? ie not logged in already 
		# true - current user is logged in,  false - no current user logged in
  end

  def sign_out
	self.current_user = nil
	cookies.delete(:remember_token)  # kill remember token in browser
  end


end
