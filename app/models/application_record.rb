class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  validates :image, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
