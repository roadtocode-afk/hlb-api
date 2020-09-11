class UsersController < ApplicationController
  before_action :authenticate_user!

  def user_details
    render json: current_user.to_json(include: :product_deals)
  end

end
