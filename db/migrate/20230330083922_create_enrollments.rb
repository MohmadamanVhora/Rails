class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :created, default: false

      t.timestamps
    end
  end
end
