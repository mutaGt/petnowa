class Public::MembersController < ApplicationController
  before_action :ensure_guest_member, only: [:edit]
  before_action :find_review, only:[:destroy]
  before_action :authenticate_member!, if: :need_auth_page?
  
  def reviews
    @reviews = current_member.reviews.order(created_at: :desc).page(params[:page])
  end
  
  def my_page
    @member = current_member
  end
  
  def password_edit
    @member = current_member
  end
  
  def password_update
    @member = current_member
    if @member.update(member_params)
      sign_in(@member, bypass: true)
      redirect_to my_page_members_path
    else
      render :password_edit
    end
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
    params.require(:member).permit(:password, :password_confirmation)  
  end
  
  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.guest?
    redirect_to my_page_members_path , alert: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
  def need_auth_page?
    unless controller_name == 'homes' && action_name =='top'
      true
    end
  end
end
