class Public::ReviewsController < ApplicationController
  
  def new
    @review = Review.new
    @review.review_tags.build
  end
  
  def create
    @review = Review.new(review_params)
    @review.member_id = current_member.id
    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end
  
  def index
    @reviews = Review.page(params[:page]).order(created_at: :desc)
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
    @word = params[:word]
    if @tag_ids.present? || params[:word].present?
      
    # tag_ids = [1, 3]

    # 商品名、タイトルもしくは本文にwordで設定された文字が含まれていれば
      @reviews = Review.joins(:tags).where("product_name LIKE ? OR title LIKE ? OR review_content LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%", "%#{params[:word]}%")
      # WHERE title LIKE '%params[:word]%' OR review_content LIKE '%params[:word]%'
      # reviews id: 1
      # tags id: 1, review_id: 1
      #.     id: 2, review_id: 1
      #.     id: 3, review_id: 1
      # joins →
      # reviews id: 1, tags id: 1, review_id: 1
      # reviews id: 1, tags id: 2, review_id: 1
      # reviews id: 1, tags id: 3, review_id: 1
  
      unless tag_ids.empty? # チェックが一つでもされていれば検索条件にタグIDを追加する
        @reviews = @reviews.where(tags: { id: tag_ids }).group(:id).having('count(*) = ?', tag_ids.size) #絞り込み(3つタグにチェックを入れたら、3つタグがついているものだけ絞り込む)
      end
      @reviews = @reviews.order(created_at: :desc).page(params[:page]).distinct #並び替えorder=順序 created_at=作成日時 desc=降順(=最新順) asc=昇順(=1.2.3...)
    else
      redirect_to request.referer, alert: "入力または選択してください"
    end
    
  end
  
  def show
    @review = Review.find(params[:id])
    @comments = @review.comments.page(params[:page])
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
      redirect_to review_path(@review)
    else
      render :edit
    end
  end
  

  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    if params[:member_review]
      redirect_to reviews_members_path
    else
      redirect_to reviews_path
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:product_name, :title, :evaluation, :review_content, :tag_ids => [])
  end
  
end
