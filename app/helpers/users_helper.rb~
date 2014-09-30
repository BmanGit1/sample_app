module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.

  def gravatar_for(user, options = { size: 50 })
	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)

	size = options[:size]

	gravatar_url = "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}" # bebfcf57d6d8277d806a9ef3385c078d for RailsTutorial gravatar#
	image_tag(gravatar_url, alt: user.name, class: "gravatar")



  end



end
