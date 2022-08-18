class Public::ReviewsController < ApplicationController
  
  def new
    @review = Review.new
    @review.review_tags.build
  end
  
  def create
    @review = Review.new(review_params)
    @review.member_id = current_member.id
    @review.save
    redirect_to reviews_path
  end
  
  def index
    @reviews = Review.all
    
    if params[:tag_ids]
      @reviews = []
      params[:tag_ids].each do |key, value|
        if value == "1"
          review_tags = Tag.find_by(name: key).reviews
          @reviews = @reviews.empty? ? review_tags : @reviews & review_tags
        end
      end
    end
  end
  
  
  #  rails map{|k, v| v == 1 ? k : nil}.compact 35~40行目をこれに置き換える事も出来る
  def search
    # チェックボックスでチェックしたtag_idを取得
    #{"1"=>"1", "2"=>"0", "3"=>"1", "4"=>"0", "5"=>"0"}
    @tag_ids = params[:tag_ids]
    tag_ids = []
    @tag_ids.keys.each do |check|
      if @tag_ids[check] == "1" # checkされていれば
        tag_ids << check.to_i
      end
    end
    # tag_ids = [1, 3]

    # タイトルもしくは本文にwordで設定された文字が含まれていれば
    @reviews = Review.includes(:tags).where("title LIKE ? OR review_content LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%")
    # WHERE title LIKE '%params[:word]%' OR review_content LIKE '%params[:word]%'

    unless tag_ids.empty?
      # チェックが一つでもされていれば検索条件にタグIDを追加する
      @reviews = @reviews.where(tags: {id: tag_ids})
    end
    @reviews_all = Review.all
    # @review_page = Review.page(params[:page])
  end
  
  def show
    @review = Review.find(params[:id])
    @comments = Comment.all
  end
  
  def edit
    @review = Review.find(params[:id])
    unless @review.member == current_member
     redirect_to reviews_path
    end
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
    redirect_to reviews_path(@review)
    else
    render :edit
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
  
  
private

def review_params
  params.require(:review).permit(:product_name, :title, :evaluation, :review_content, :tag_ids => [])
end
  
end
