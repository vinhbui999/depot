# frozen_string_literal: true

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
unless company
  (1..2).each do |i|
    Company.create!(name: "Company-#{i}",
                    address: "Company#{i}-Address",
                    phonenumber: '0123723452',
                    email: "company#{i}@example.com")
  end
end

product = Product.first
unless product
  (1..10).each do |i|
    i = if i.even?
          2
        else
          1
        end
    Product.create!(title: "Product-#{i}",
                    description:
              %(
                  Answer the question “Can we build this for ALL the devices?” with a
                  resounding YES. This book will help you get there with a real-world
                  introduction to seven platforms, whether you’re new to mobile or an
                  experienced developer needing to expand your options. Plus, you’ll find
                  out which cross-platform solution makes the most sense for your needs.
              ),
                    image_url: 'chair.png',
                    price: 100,
                    company_id: i.to_s)
  end
end

user = AdminUser.where(email: 'admin@example.com').first
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless user
