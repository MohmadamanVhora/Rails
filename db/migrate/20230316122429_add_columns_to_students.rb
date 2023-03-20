class AddColumnsToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :email, :string
    add_column :students, :student_update_counter, :integer, default: 0
  end
end
