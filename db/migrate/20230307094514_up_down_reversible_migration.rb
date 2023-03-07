class UpDownReversibleMigration < ActiveRecord::Migration[7.0]
  def up
    drop_table :samples
  end

  def down
    create_table :samples do |t|
      t.string :name

      t.timestamps
    end
  end
end
