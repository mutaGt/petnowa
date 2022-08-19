class Public::MembersController < ApplicationController
  before_action :ensure_guest_member, only: [:edit]
  
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
    if @member.update(member_params)
      if params[:member][:password] && params[:member][:password_confirmation]
        sign_in(@member, bypass: true)
      end
    redirect_to member_my_page_path(@member)
    end
  end
  
  def password_edit
    @member = current_member
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
    params.require(:member).permit(:name, :email, :image, :password, :password_confirmation, :reset_password_token)  
  end
  
   def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == "guestuser"
      redirect_to member_path(current_member) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
   end  
  
end
