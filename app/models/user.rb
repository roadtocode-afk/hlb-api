class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  validates :email, :password, presence: true
  validates :email, uniqueness: true

  validates :password, length: { minimum: 6 }

  has_many :product_deals
  has_many :favorite_product_deals
  has_many :user_comments
end
