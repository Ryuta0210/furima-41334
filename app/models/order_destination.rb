class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street, :building, :phone, :item_id, :user_id

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は半角数字で半角の「-」を入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を入力してください' }
    validates :city, :street, presence: { message: 'を入力してください' }
    validates :phone, format: { with: /\A\d+\z/, message: 'は半角数字で入力してください' }
  end

  def save
    order = Order.create(item_id:, user_id:)
    Destination.create(post_code:, prefecture_id:, city:, street:, building:,
                       phone:, order_id: order.id)
  end
end
