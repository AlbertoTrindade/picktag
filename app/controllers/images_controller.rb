class ImagesController < ApplicationController
  before_action :signed_in_user

  def new
    @image = current_user.images.build
  end

  def create
    @image = current_user.images.build(image_params)
    if @image.save
      flash[:success] = "Image uploaded!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
  end

  private

    def image_params
      params.require(:image).permit(:img, :tag)
    end
end