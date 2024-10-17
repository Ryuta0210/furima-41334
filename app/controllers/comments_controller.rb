class CommentsController < ApplicationController
  before_action :set_item

  def create
    @comment = @item.comments.new(comment_params)
    @comment.save
    @comments = @item.comments.includes(:user).order(created_at: :desc)
    render json: { comments: @comments.as_json(include: { user: { only: [:nickname] } }) }
  end

  def destroy
    @comment = @item.comments.includes(:user).find(params[:id])
    @comment.destroy
    @comments = @item.comments.includes(:user).order(created_at: :desc)
    render json: { comments: @comments.as_json(include: { user: { only: [:nickname] } }) }
  end

  def update
    @comment = @item.comments.find(params[:id]) 
    @comment.update(comment_params)
    @comments = @item.comments.includes(:user).order(created_at: :desc)
    render json: { comments: @comments.as_json(include: { user: { only: [:nickname] } }) }
  end

  private

  def set_item
    @item = Item.includes(:comments).find(params[:item_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
