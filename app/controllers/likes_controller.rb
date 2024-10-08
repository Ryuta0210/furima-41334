class LikesController < ApplicationController
  before_action :set_item

  def create
    @like = Like.new(user_id: current_user.id, item_id: @item.id)
    if @like.save
      @item.increment!(:likes_count)
      render turbo_stream: turbo_stream.replace('likes-count', partial: 'items/likes_count', locals: { likes_count: @item.likes_count }),
             status: :ok
    else
      head :ok
    end
  end

  def destroy
    @like = @item.likes.find_by(user_id: current_user.id)

    if @like&.destroy
      @item.decrement!(:likes_count)
      render turbo_stream: turbo_stream.replace('likes-count', partial: 'items/likes_count', locals: { likes_count: @item.likes_count }),
             status: :ok
    else
      head :ok
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
