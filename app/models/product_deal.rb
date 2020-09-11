class ProductDeal < ApplicationRecord

  belongs_to :user
  has_many :favorite_product_deals
  has_many :user_comments
end
