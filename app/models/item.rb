class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :delivery_schedule

  validates :image, presence: { message: 'をアップロードしてください' }
  validates :name, presence: { message: 'を入力してください' }
  validates :description, presence: { message: 'を入力してください' }
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :status_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_cost_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :delivery_schedule_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :price, presence: { message: 'を入力してください' }
  validates :price, format: { with: /\A\d+\z/, message: 'は半角の数字で入力してください' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'は半角数字で¥300〜¥9,999,999の間で設定してください' }

  belongs_to :user
  has_one_attached :image
end
