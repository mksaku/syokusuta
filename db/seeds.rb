# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
30.times do
email = Faker::Internet.email
name = Faker::LordOfTheRings.character
password = "password"
avatar = Faker::Avatar.image
user = User.new(
email: email,
name: name,
password: password,
password_confirmation: password,
avatar: avatar,
uid: SecureRandom.uuid,
)
user.skip_confirmation!
user.save
end

30.times do
  follower_id = [*1..20].sample
  followed_id = [*1..20].sample
  while follower_id == followed_id
    followed_id = [*1..20].sample
  end
    Relationship.find_or_create_by(
    follower_id: follower_id,
    followed_id: followed_id
  )
end

60.times do |t|
 title = Faker::Book.title
  content = Faker::Beer.name
  Up.create!(title: title,
               content: content,
              )

end

20.times do |p|
  content = Faker::Bank.name
  Comment.create!(content: content,
                  )
end
