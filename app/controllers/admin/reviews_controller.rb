class Admin::ReviewsController < ApplicationController
  
  def index
    @reviews = Review.page(params[:page])
    @reviews.each do |review|
      review.set_image_url
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews
  end
  
end
