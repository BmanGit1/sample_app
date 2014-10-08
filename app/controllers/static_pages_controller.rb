class StaticPagesController < ApplicationController

  def home
	@micropost = current_user.microposts.build if signed_in?  # enable post field
	@feed_items = current_user.feed.paginate(page: params[:page]) # pull params for page
  end

  def help
  end

  def about
  end

  def contact
  end

end
