class CreateUserComments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_comments do |t|
      t.references :user, foreign_key: true
      t.references :product_deal, foreign_key: true
      t.timestamps
      t.text :body, null: false
    end
  end
end
