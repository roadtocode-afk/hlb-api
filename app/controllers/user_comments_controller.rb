class UserCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @user_comment = UserComment.new(comment_params)
    @user_comment.user_id = current_user.id
    @user_comment.product_deal_id = params[:product_deal_id]
    if @user_comment.save
      user_comment_json = @user_comment.as_json
      user_comment_json["user"] = @user_comment.user
      render json: user_comment_json
    end
  end


  def product_deal_comments
    @prod_deal_comments = UserComment.where(product_deal_id: params[:product_deal_id])
    prod_deal_comments = @prod_deal_comments.map do |comment|
      comment_json = comment.as_json
      comment_json["user"] = comment.user
      comment = comment_json
    end
    render json: prod_deal_comments
  end

  private

  def comment_params
    params.require(:user_comment).permit(:body, :product_deal_id)
  end
end
