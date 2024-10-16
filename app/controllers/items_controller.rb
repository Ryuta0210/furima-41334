class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :verification_user, only: [:destroy, :edit]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.order(updated_at: :desc)
    render 
  end

  def edit
    redirect_to root_path if @item.sold_out
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to item_path(@item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :category_id, :description, :status_id, :shipping_cost_id, :prefecture_id,
                                 :delivery_schedule_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.includes(:comments).find(params[:id])
  end

  def verification_user
    return unless current_user.id != @item.user_id

    redirect_to root_path
  end
end
