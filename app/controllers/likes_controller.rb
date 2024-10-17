class LikesController < ApplicationController
  before_action :set_item
  before_action :authenticate_user!

  def create
    like = Like.find_by(user_id: current_user.id, item_id: @item.id)
    if like
      like.destroy
      @item.decrement!(:likes_count)
      render json: { likes_count: @item.likes_count, liked: false }
    else
      @like = Like.new(user_id: current_user.id, item_id: @item.id)
      if @like.save
        @item.increment!(:likes_count)
        render json: { likes_count: @item.likes_count, liked: true }
      else
        render json: { error: 'いいねできませんでした' }, status: :unprocessable_entity
      end
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
