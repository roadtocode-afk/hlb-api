class ProductDealsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :user_favorites]
  def create
    @product_deal = ProductDeal.new(product_deal_params)
    # image = Cloudinary::Uploader.upload(params[:image])
    # @product_deal.img_url = image["url"]
    @product_deal.user_id = current_user.id
    if @product_deal.save
      render json: @product_deal
    else
      #errors go here
    end
  end

  def show
    @product_deal = ProductDeal.find(params[:id])
    render json: @product_deal
  end

  def index
    @product_deals = ProductDeal.order(created_at: :desc)
    render json: @product_deals
  end

  def favorite_product_deals
    @favorite_product_deals = ProductDeal.order(favorited_count: :desc).limit(5)
    render json: @favorite_product_deals
  end

  def user_favorites
    @user_favorites = FavoriteProductDeal.where(user_id: current_user.id)
    render json: @user_favorites
  end

  def new_product_deals
    @new_prod_deals = ProductDeal.order(created_at: :desc).limit(5)
    render json: @new_prod_deals
  end

  def filter_deals
    if params[:type] == "Newest"
      @product_deals = ProductDeal.order(created_at: :desc)
    elsif params[:type] == "Oldest"
      @product_deals = ProductDeal.order(created_at: :asc)
    elsif params[:type] == "Glass"
      @product_deals = ProductDeal.where(product_type: "Glass")
    elsif params[:type] == "Rolling Paper"
      @product_deals = ProductDeal.where(product_type: "Rolling Paper").order(created_at: :desc)
    elsif params[:type] == "Grinder"
      @product_deals = ProductDeal.where(product_type: "Grinder").order(created_at: :desc)
    elsif params[:type] == "Lighter"
      @product_deals = ProductDeal.where(product_type: "Lighter").order(created_at: :desc)
    elsif params[:type] == "Torch"
      @product_deals = ProductDeal.where(product_type: "Torch").order(created_at: :desc)
    end
    render json: @product_deals
  end

  private

  def product_deal_params
    params.require(:product_deal).permit(:title, :description, :exp_date, :new_price, :product_type, :web_link, :original_price, :img_url, :manufacturer)
  end

end
