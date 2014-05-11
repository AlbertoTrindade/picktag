class ImagesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy

  def new
    @image = current_user.images.build
  end

  def create
    @image = current_user.images.build(image_params)
    @image.rating = 0
    if @image.save
      flash[:success] = "Image uploaded!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy
    @image.destroy
    redirect_to current_user
  end

  private

    def image_params
      params.require(:image).permit(:img, :tag)
    end

    def correct_user
      @image = current_user.images.find_by(id: params[:id])
      redirect_to root_url if @image.nil?
    end
end