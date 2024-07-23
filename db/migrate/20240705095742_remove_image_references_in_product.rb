# frozen_string_literal: true

class RemoveImageReferencesInProduct < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :image_id
  end
end
