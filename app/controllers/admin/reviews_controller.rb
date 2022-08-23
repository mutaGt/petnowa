class Admin::ReviewsController < ApplicationController
  
  def index
    @reviews = Review.page(params[:page])
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews
  end
  
end
