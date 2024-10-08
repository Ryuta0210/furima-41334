class LikesController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!

  def create
    return if Like.exists?(user_id: current_user.id, item_id: @item.id)

    @like = Like.new(user_id: current_user.id, item_id: @item.id)
    if @like.save
      @item.increment!(:likes_count)
      render json: { likes_count: @item.likes_count }
    else
      render json: { error: 'いいねできませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
