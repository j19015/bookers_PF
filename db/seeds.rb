# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

email_array = ["a@a", "b@b", "c@c", "d@d"]

email_array.each do |e,i|
  User.create(
    email: e,
    name: "user#{i}",
    password: "aaaaaa"
  )
end

user_array = [1,2,3,4]

user_array.each do |follower|
  user_array.each do |followed|
    Relationship.create(
      follower_id: follower,
      followed_id: followed
    )
  end
end

