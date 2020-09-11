class CreateFavoriteProductDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_product_deals do |t|
      t.references :user, foreign_key: true
      t.references :product_deal, foreign_key: true
      t.timestamps
    end
    # add_index :favorite_product_deals, :user_id
    # add_index :favorite_product_deals, :product_deal_id
    add_index :favorite_product_deals, [:product_deal_id, :user_id], unique: true 
  end
end
