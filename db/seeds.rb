# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'digest/sha1'
srand
seed = "--#{rand(10000)}--#{Time.now}--"
# for i in 0..100
#   seed = "--#{rand(10000)}--#{Time.now}--"
#   User.create!(
#       email: "#{Digest::SHA1.hexdigest(seed)[0,8]}@seznam.cz",
#       password: "testadminuser",
#       password_confirmation: "testadminuser",
#       first_name: Digest::SHA1.hexdigest(seed)[0,8],
#       surname: Digest::SHA1.hexdigest(seed)[0,8],
#       gym_id: 1,
#       gender: 1
#     )
#   end

@ch = Challenge.last
@users = User.all
prng = Random.new
for i in 5..50
  ChallengeScore.create!(
  url: prng.rand(1000),
  user: @users[i],
  challenge: @ch,
  gym: @users[i].gym,
  challenge_time: "#{prng.rand(10)}:#{prng.rand(60)}"
  )
end
