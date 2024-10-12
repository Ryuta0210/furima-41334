class CommentsController < ApplicationController
  before_action :set_item

  def create
    @comment = @item.comments.new(comment_params)
    @comment.save
    redirect_to item_path(@item)
    render json: { post: }
  end

  def destroy
    @comment = @item.comments.find(params[:id])
    @comment.destroy
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
