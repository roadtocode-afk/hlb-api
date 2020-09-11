class FavoriteProductDealsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :user_fav_prod_deal, :user_fav_prod_deals, :destroy]

  def create
    @favorite_product_deal = FavoriteProductDeal.new(user_id: current_user.id, product_deal_id: params[:product_deal_id])
    product_deal = ProductDeal.find(@favorite_product_deal.product_deal_id)
    new_count = product_deal.favorited_count += 1
    if product_deal.update_attribute(:favorited_count, new_count)
      if @favorite_product_deal.save
        render json: { fav_prod_deal: @favorite_product_deal, favorited_count: product_deal.favorited_count }
      else
      #errors go here
      end
    end
  end

  def destroy
      @favorite_product_deal = FavoriteProductDeal.find(params[:id])
      product_deal = ProductDeal.find_by(id: @favorite_product_deal.product_deal_id)
      if product_deal.nil?
        render json: {}
      else
        product_deal.favorited_count -= 1
        product_deal.save!
        @favorite_product_deal.destroy!
        render json: product_deal
      end
  end

  def user_fav_prod_deals
      usr_fav_prod_deals = FavoriteProductDeal.where(user_id: current_user.id)
      product_deal_ids = usr_fav_prod_deals.pluck(:product_deal_id)
      if params[:type].nil?
        user_fav_product_deals = ProductDeal.where(id: product_deal_ids)
        other_prod_deals =  ProductDeal.order(created_at: :desc) - user_fav_product_deals
      elsif params[:type] == "Newest"
        user_fav_product_deals = ProductDeal.where(id: product_deal_ids).order(created_at: :desc)
        other_prod_deals = ProductDeal.order(created_at: :desc) - user_fav_product_deals
      elsif params[:type] == "Oldest"
        user_fav_product_deals = ProductDeal.where(id: product_deal_ids).order(created_at: :asc)
        other_prod_deals = ProductDeal.order(created_at: :asc) - user_fav_product_deals
      else
        user_fav_product_deals = ProductDeal.where(id: product_deal_ids, product_type: params[:type])
        other_prod_deals =  ProductDeal.where(product_type: params[:type]).order(created_at: :desc) - user_fav_product_deals
      end
      prod_deals = user_fav_product_deals.map do |user_fav_prod_deal|
          user_fav_prod_deal_json = user_fav_prod_deal.as_json
          user_fav_prod_deal_json["fav_prod_deal"] = usr_fav_prod_deals.find_by(product_deal_id: user_fav_prod_deal.id)
          user_fav_prod_deal = user_fav_prod_deal_json
      end

    render json: {user_fav_prod_deals: prod_deals, other_prod_deals: other_prod_deals}
  end

  def recently_fav_prod_deals
    recently_fav_prod_deals = FavoriteProductDeal.where('created_at >= ?', 2.days.ago).limit(6)
    @prod_deals = ProductDeal.where(id: recently_fav_prod_deals.pluck(:product_deal_id))
    render json: @prod_deals
  end

  def user_fav_prod_deal
      @usr_fav_prod_deal = FavoriteProductDeal.find_by(product_deal_id: params[:product_deal_id], user_id: current_user.id)
      product_deal = ProductDeal.find_by(id: @usr_fav_prod_deal.product_deal_id)
      render json: { fav_prod_deal: @usr_fav_prod_deal, favorited_count: product_deal.favorited_count }
  end

  private

end
