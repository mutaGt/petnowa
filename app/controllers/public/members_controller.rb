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
    redirect_to members_my_page_path
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
    params.require(:member).permit(:name, :email, :password, :image)  
  end
end
