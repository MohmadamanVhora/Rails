# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |i|
  if i<=4
    Book.create(name: "Book#{i+5}", price: 1000+i, author_id: i+1)  
  else
    Book.create(name: "Book#{i+5}", price: 1000+i, author_id: i-4)  
  end
end
