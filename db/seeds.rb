# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create users
ActiveRecord::Base.transaction do
  40.times do |n|
    email = "example-#{n+1}@example.org"
    password = "password"
    message = "email: #{email}\nreddit: u/blahblah"
    longitude = (rand - 0.5) * 300
    latitude = (rand - 0.5) * 120
    User.create!(email: email,
                 latitude: latitude,
                 longitude: longitude,
                 message: message,
                 password:              password,
                 password_confirmation: password)
  end
end
users = User.all

# Create maps
ActiveRecord::Base.transaction do
  10.times do
    title = "#{Faker::Hacker.adjective} #{Faker::Hacker.noun} map"
    description = Faker::Lorem.sentence(10)
    users.sample.maps.create!(title: title, description: description)
  end
end
maps = Map.all

# Join maps
ActiveRecord::Base.transaction do
  users.each do |user|
    maps.sample(maps.count / 2).each do |map|
      map.members << user
    end
  end
end