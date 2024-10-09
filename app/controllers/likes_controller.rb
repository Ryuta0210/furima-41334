class LikesController < ApplicationController
  before_action :set_item

  def create
    @like = Like.new(user_id: current_user.id, item_id: @item.id)
    if @like.save
      @item.increment!(:likes_count) # いいね数を増やす
      render json: { likes_count: @item.likes_count } # 成功時にいいね数をJSONで返す
    else
      render json: { error: 'いいねできませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
