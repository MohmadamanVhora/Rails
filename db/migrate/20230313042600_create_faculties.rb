class CreateFaculties < ActiveRecord::Migration[7.0]
  def change
    create_table :faculties do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_no
      t.string :email
      t.date :date_of_birth
      t.string :designation

      t.timestamps
    end
  end
end
