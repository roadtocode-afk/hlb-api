class CreateProductDeals < ActiveRecord::Migration[5.1]
  def change
    create_table :product_deals do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :user, foreign_key: true
      t.datetime :exp_date, null: false
      t.string :img_url, null: false
      t.float :new_price, null: false
      t.string :product_type, null: false
      t.float :original_price, null: false
      t.string :web_link, null: false
      t.string :manufacturer, null: false
      t.integer :favorited_count, default: 0
      t.boolean :redeemed
      t.timestamps
    end
    add_index :product_deals, :favorited_count
  end
end
