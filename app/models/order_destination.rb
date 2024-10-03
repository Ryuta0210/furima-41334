class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street, :building, :phone, :item_id, :user_id, :token

  with_options presence: { message: 'を入力してください' } do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は半角数字で半角の「-」を入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city, :street, :token, :user_id, :item_id
    validates :phone, format: { with: /\A\d{10,11}+\z/, message: 'は半角数字で、10桁以上11桁以下で入力してください' }
  end

  def save
    order = Order.create(user_id:, item_id:)
    Destination.create(post_code:, prefecture_id:, city:, street:, building:,
                       phone:, order_id: order.id)
  end
end
