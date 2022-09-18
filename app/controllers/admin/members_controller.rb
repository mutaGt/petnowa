class Admin::MembersController < ApplicationController

  def index
    @members = Member.page(params[:page])
  end
  
  def show
    @member = Member.find(params[:id])
    @reviews = @member.reviews.order(created_at: :desc)
  end
  
  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to admin_member_path(@member)
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end
  
  private
  
  def member_params
    params.require(:member).permit(:is_deleted)
  end
  
end
