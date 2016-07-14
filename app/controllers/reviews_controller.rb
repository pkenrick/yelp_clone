class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    p "the params are: #{params}"
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)
    
    if @review.save
      p 'saved ok'
      redirect_to restaurants_path
    else
      p 'did not save'
      if @review.errors[:user]
        p @review.errors[:user]
        p 'there is an error in ":user" key'
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        p 'there was another error'
        render :new
      end
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
