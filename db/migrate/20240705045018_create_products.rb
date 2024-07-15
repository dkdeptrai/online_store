class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.string :code
      t.string :heel_height
      t.text :description
      t.numeric :price

      t.timestamps
    end
  end
end
