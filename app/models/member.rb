class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestuser"
    end
  end
end
