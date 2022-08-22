class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :image, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  
  GUEST_USER_EMAIL = "guest@example.com"
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  def self.guest
    find_or_create_by!(name: "guestuser", email: GUEST_USER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end
  
  def guest?
    email == GUEST_USER_EMAIL
  end
end
