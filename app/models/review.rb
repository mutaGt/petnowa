class Review < ApplicationRecord
  belongs_to :member
  has_many :review_tags
  has_many :tags, through: :review_tags
  has_many :comments, dependent: :destroy
  
  accepts_nested_attributes_for :review_tags, allow_destroy: true
end
