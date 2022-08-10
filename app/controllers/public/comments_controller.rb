class Public::CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.member_id = current_member.id
    @comment.save
    redirect_to review_path(@comment)
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to review_path(@comment)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment_content)
  end
  
end
