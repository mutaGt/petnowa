class Public::CommentsController < ApplicationController
  before_action :authenticate_member!, if: :need_auth_page?
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.member_id = current_member.id
    @comment.review_id = params[:review_id]
    if @comment.save
    redirect_to review_path(@comment.review.id)
    else
    render :new
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
    unless @comment.member == current_member
      redirect_to review_path(@comment.review.id)
    end
  end
  
  def update
    @comment = Comment.find(params[:id])
    unless @comment.member == current_member
      redirect_to review_path(@comment.review.id)
      return
    end
    @comment.update(comment_params)
    redirect_to review_path(@comment.review.id)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    unless @comment.member == current_member
      redirect_to review_path(@comment.review.id)
      return
    end
    @comment.destroy
    redirect_to reviews_path
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
  
  def need_auth_page?
    unless controller_name == 'homes' && action_name =='top'
      true
    end
  end
  
end
