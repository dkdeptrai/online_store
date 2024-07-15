class ChangeProductBrandToReferences < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :brand, :string
    add_reference :products, :brand, foreign_key: true, null: false
  end
end
