class AddImageReferencesToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :image, null: false, foreign_key: true
  end
end
