class ImagesController < ApplicationController
  def create; end

  private

  def image_params
    params.require(:image).permit
  end
end
