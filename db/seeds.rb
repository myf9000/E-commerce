# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(
             email: "ja180@vp.pl",
             password:              "plusiminus1",
             password_confirmation: "plusiminus1")

User.create!(
             email: "ja181@vp.pl",
             password:              "plusiminus1",
             password_confirmation: "plusiminus1",
             admin:     true)