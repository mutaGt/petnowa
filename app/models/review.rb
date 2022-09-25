class Review < ApplicationRecord
  belongs_to :member
  has_many :review_tags, dependent: :destroy
  has_many :tags, -> { order(id: :asc) }, through: :review_tags
  has_many :comments, dependent: :destroy
  
  
  accepts_nested_attributes_for :review_tags, allow_destroy: true
  
  validates :product_name, presence: true,
    length: { minimum: 2, maximum: 70 }
  validates :title, presence: true,
    length: { maximum: 30 }
  validates :tag_ids, presence: true
  validates :evaluation, presence: true
  validates :review_content, presence: true,
    length: { maximum: 500 }
  validate :validate_product_name 

  before_save do #保存の直前に楽天APIが叩かれる(新規作成と編集時)
    set_image_url
  end
  
  def set_image_url
    items = RakutenWebService::Ichiba::Item.search(keyword: product_name.gsub(/[[:space:]]+/, "")) #スペースを除いて検索する(空文字に置き換えてる＝スペースは削除される)
    
    if items.count >= 1 # 検索結果が1件以上あれば
      self.image_url = items.first["mediumImageUrls"][0]
    else # 検索結果が0件であればno_imageを表示
      self.image_url = "no_image.jpg"
    end
  end
  
  def validate_product_name 
    if product_name.gsub(/[[:space:]]+/, "").length >= 2 #商品名の中にスペースがあれば取り除いた長さが2文字以上であるか
      return
    end
    errors.add(:product_name, "はスペースを除いて2文字以上入力してください")
  end
    
end
