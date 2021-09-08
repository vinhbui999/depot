# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Product.delete_all
# User.delete_all
# Cart.delete_all
# LineItem.delete_all
# Order.delete_all
company = Company.first
(1..2).each do |i|
    Company.create!(name: "#{Faker::Company.name}", 
        address:"#{Faker::Address.full_address}", 
        phonenumber:"#{Faker::Number.leading_zero_number(digits: 10)}",
        email: "company#{i}@example.com"
    )
end unless company

product = Product.first
(1..10).each do |i|
    if i%2 == 0
        i = 2
    else
        i = 1
    end
    Product.create!(title: "#{Faker::Company.name}", 
        description: 
            %{
                Answer the question “Can we build this for ALL the devices?” with a
                resounding YES. This book will help you get there with a real-world
                introduction to seven platforms, whether you’re new to mobile or an
                experienced developer needing to expand your options. Plus, you’ll find
                out which cross-platform solution makes the most sense for your needs.
            },
        image_url: "chair.png",
        price: Faker::Number.decimal(l_digits: 2),
        company_id:"#{i}"
    )
end unless product

user = AdminUser.where(email: "admin@example.com").first
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless user
