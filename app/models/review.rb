class Review < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :review_tags
  belongs_to :member
end
