class Review < ApplicationRecord
  belongs_to :member
  has_many :review_tags
  has_many :tags, through: :review_tags
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

  attribute :image_url, :string
  
  def set_image_url
    items = RakutenWebService::Ichiba::Item.search(keyword: product_name.gsub(/[[:space:]]+/, "")) #スペースを除いて検索する(空文字に置き換えてる＝スペースは削除される)
    item = false
    items.each do |i|
      # itemがあれば
      if i.present?
        item = true
        break
      end
    end
    if item
      # 楽天にあれば持ってきた画像を表示
      self.image_url = items.first["mediumImageUrls"][0]
    else
      # 楽天になければno_imageを表示
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
