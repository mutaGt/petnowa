class Admin::MembersController < ApplicationController
  
  def index
    @members = Member.all
  end
  
  def show
    @member = Member.find(params[:id])
    @reviews = @memver.reviews
  end
  
  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to admin_member_path(@member)
  end
  
  def destroy
    @review = Member.find(params[:id])
    @review.destroy

  end
  
  private
  
  def member_params
    params.require(:member).permit(:is_deleted)
  end
  
end
