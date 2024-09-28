class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street, :building, :phone, :item_id, :user_id

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city, :street
    validates :phone, format: { with: /\A\d+\z/, message: 'is needed to input' }
  end

  def save
    order = Order.create(item_id:, user_id:)
    Destination.create(post_code:, prefecture_id:, city:, street:, building:,
                       phone:, order_id: order.id)
  end
end
