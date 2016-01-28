User.create!(
             email: "user@vp.pl",
             password:              "12345678",
             password_confirmation: "12345678")

User.create!(
             email: "admin@vp.pl",
             password:              "12345678",
             password_confirmation: "12345678",
             admin:     true)

Category.create!(name: "Clothes")
Category.create!(name: "Phones")
Category.create!(name: "Car")
Category.create!(name: "Book")

Category.create!(name: "T-shirt", parent_id: 1)
Category.create!(name: "Hat", parent_id: 1)
Category.create!(name: "Iphone", parent_id: 2)
Category.create!(name: "Samsung s5", parent_id: 2)
Category.create!(name: "Mercedes", parent_id: 3)
Category.create!(name: "BMW", parent_id: 3)
Category.create!(name: "Fantasy", parent_id: 4)
Category.create!(name: "Novel", parent_id: 4)