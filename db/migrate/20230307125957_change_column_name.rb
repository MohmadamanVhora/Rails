class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :authors, :dob, :date_of_birth
  end
end
