class Public::MembersController < ApplicationController
  
  def index
    @reviews = current_member.reviews
  end
  
  def show
    @member = current_member
  end
  
  def edit
    @member = current_member
  end
  
  def update
    @member = current_member
    @member.update(member_params)
    redirect_to member_my_page_path(@member)
  end
  
  def password_edit
    @member = current_member
  end
  
  def password_update
    @member = current_member
    @member.update(member_password_params)
    redirect_to member_my_page_path(@member)
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to members_path
  end
  
  def unsubscribe
    @member = current_member
  end
  
  def withdraw
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  def member_params
    params.require(:member).permit(:name, :email, :image)  
  end
  
  def member_password_params
    params.require(:member).permit(:password)  
  end
end