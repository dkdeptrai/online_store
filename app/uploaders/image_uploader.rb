# frozen_string_literal: true

# app/uploaders/image_uploader.rb
class ImageUploader
  def self.upload(image, _product_id)
    Rails.logger.debug("Uploading image: #{image}")
    uploaded_image = Cloudinary::Uploader.upload(image)
    puts "Image uploaded url: #{uploaded_image['secure_url']}"
    uploaded_image['secure_url']
  rescue StandardError => e
    Rails.logger.debug("Error uploading image: #{e}")
  end
end
