namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

	# Create Admin user with special Email, Password and admin toggle set to YES
	admin = User.create!(	name: "Example User",
			email: "example@railstutorial.org",
			password: "foobar",
			password_confirmation: "foobar")
	admin.toggle!(:admin)	# switch admin to YES for this user

	#create second admin user as bman
	admin2 = User.create!(	name: "bman",
			email: "bman@bman.com",
			password: "123456",
			password_confirmation: "123456")
	admin2.toggle!(:admin)	# switch admin to YES for this user

	# create users
	99.times do |n|
	  name = Faker::Name.name  # create fake names
	  email = "example-#{n+1}@railstutorial.org"
	  password = "password"
	  User.create!(name: name,
			email: email,
			password: password,
			password_confirmation: password)
	end

	# create 50 posts each for first 6 users
	users = User.all(limit:6)  # get first 6 users
	50.times do
	  content = Faker::Lorem.sentence(5)   # set content to Faker misc latin
	  users.each { |user| user.microposts.create!(content: content) }  # run through each of the 6 users
	end
  end
end
