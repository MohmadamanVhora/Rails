class AddColumnToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :age, :integer
  end
end
