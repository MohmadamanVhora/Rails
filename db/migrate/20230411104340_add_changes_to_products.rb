class AddChangesToProducts < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :name, :title
    remove_column :products, :category, :string
    add_column :products, :capacity, :integer
    add_column :products, :is_active, :boolean
    add_column :products, :product_status, :string
  end
end
