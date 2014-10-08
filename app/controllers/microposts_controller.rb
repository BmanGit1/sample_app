class MicropostsController < ApplicationController

#Check if user is signed in before allowing them post methods
before_filter :signed_in_user     # hit signed-in-user check method in session_helpers

before_filter :correct_user, only: :destroy  # only user=micropost originator can destroy post


  # run this if Post Button is pressed
  def create
	@micropost = current_user.microposts.build(params[:micropost])
	if @micropost.save
	  flash[:success] = "Micropost created!"
	  redirect_to root_path
	else
	  @feed_items = []        # bad micropost so zero out the feed_items
	  render 'static_pages/home'  # return to home page
	end
  end



  def destroy
	@micropost.destroy
	redirect_back_or root_path
  end


  private

	def correct_user  # find microposts ONLY belonging to current user (for deleting)
	  @micropost = current_user.microposts.find_by_id(params[:id])
	  redirect_to root_path if @micropost.nil?
	end


end
