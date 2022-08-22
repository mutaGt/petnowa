class Review < ApplicationRecord
  belongs_to :member
  has_many :review_tags
  has_many :tags, through: :review_tags
  has_many :comments, dependent: :destroy
  
  accepts_nested_attributes_for :review_tags, allow_destroy: true
  
  validates :product_name, presence: true
  validates :title, presence: true
  validates :review_content, presence: true

  attribute :image_url, :string
  
  def set_image_url
    items = RakutenWebService::Ichiba::Item.search(keyword: product_name)
    self.image_url = items.first["mediumImageUrls"][0]
  end
end
