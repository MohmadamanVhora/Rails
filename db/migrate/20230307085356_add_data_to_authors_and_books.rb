class AddDataToAuthorsAndBooks < ActiveRecord::Migration[7.0]
  def change
    5.times do |i|
      Author.create(first_name: "Aman#{i}", last_name: "Vhora", dob: "04-08-2002", email: "aman#{i}@vhora.com")
      Book.create(name: "Book#{i}", price: 599 + i, author_id: Author.first.id)
    end
  end
end
