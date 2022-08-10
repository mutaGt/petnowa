class Public::ReviewsController < ApplicationController
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.member_id = current_member.id
    redirect_to reviews_path
  end
  
  def index
    @reviews = Review.all
    @review = Review.new
  end
  
  def search
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to reviews_path
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
  
  
private

def review_params
  params.require(:review).permit(:title, :product_name, :evaluation, :review_content)
end
  
end
