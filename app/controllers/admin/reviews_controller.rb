class Admin::ReviewsController < ApplicationController

  def index
    @reviews = Review.page(params[:page]).order(created_at: :desc)
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to request.referer
  end
  
end
