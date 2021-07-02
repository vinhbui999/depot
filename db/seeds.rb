# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.delete_all
(1..10).each do |i|
    Product.create!(title: "Seven Mobile App in Seven Weeks #{i}", 
        description: 
            %{<p>
                <em>Native Apps, Multiple Platforms</em>
                Answer the question “Can we build this for ALL the devices?” with a
                resounding YES. This book will help you get there with a real-world
                introduction to seven platforms, whether you’re new to mobile or an
                experienced developer needing to expand your options. Plus, you’ll find
                out which cross-platform solution makes the most sense for your needs.
            </p>},
        image_url: "chair.png",
        price: 26.00
    )
end