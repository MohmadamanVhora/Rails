# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |i|
  Book.find_or_create_by(name: "Book#{i+20}", price: 1000 + i, author_id: Author.first.id)
end

20.times do |i|
  Employee.find_or_create_by(first_name: "Aman#{i+1}",last_name: "Vhora#{i+1}",  email: "aman@vhora#{i+1}", age: rand(15..35), no_of_order: rand(1..15), full_time_available: [true, false].sample, salary: rand(35..60)*1000)
end
