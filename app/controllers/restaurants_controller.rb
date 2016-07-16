class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  # before_action :check_user, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    # @restaurant = Restaurant.find(params[:restaurant_id])
    # @review = @restaurant.reviews.build_with_user(review_params, current_user)

      @restaurant = Restaurant.create_with_user(restaurant_params, current_user)

    # @restaurant = Restaurant.new(restaurant_params)
    # @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless @restaurant.belongs_to?(current_user)
      flash.keep[:notice] = 'You cannot edit restaurant you did not create'
      redirect_to '/restaurants'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.belongs_to?(current_user)
      @restaurant.destroy
      flash.keep[:notice] = 'Restaurant deleted successfully'
    else
      flash.keep[:notice] = 'You cannot delete restaurant you did not create'
    end
    redirect_to '/restaurants'
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :image)
  end

end
