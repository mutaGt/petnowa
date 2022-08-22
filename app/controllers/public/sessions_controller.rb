# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to reviews_path, notice: "ゲストユーザーでログインしました。"
  end
  
  def after_sign_in_path_for(resource)
    reviews_path
  end
  
  def after_sign_out_path_for(resource)
     root_path
  end
  
  protected
  
  def member_state
    @member = Member.find_by(email: params[:member][:email])
    return if !@member
    if @member.valid_password?(params[:member][:password])
    end
  end
  
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
