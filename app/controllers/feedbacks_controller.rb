class FeedbacksController < ApplicationController
  before_action :signed_in_user

  def create
  	@feedback = current_user.feedbacks.build(feedback_params)
    if @feedback.save
      feedback_image = Image.find(@feedback.image_id)
      feedback_image.user.update_reputation
      feedback_image.update_rating
      flash[:success] = "Thank you for your feedback!"
      redirect_to :back
    else
      flash[:error] = "Error when trying to get your feedback."
      redirect_to :back
    end
  end

  private

    def feedback_params
      filtered_params = params.require(:feedback).permit(:image_id)
      if params[:commit] == "Yes"
  		filtered_params.merge!(relevant: true)
  	  else
  		filtered_params.merge!(relevant: false)
  	  end
    end
end