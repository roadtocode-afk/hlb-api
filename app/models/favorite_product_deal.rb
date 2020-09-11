class FavoriteProductDeal < ApplicationRecord
  belongs_to :user
  belongs_to :product_deal
end
