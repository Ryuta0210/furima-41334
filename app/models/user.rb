class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d).+\z/, message: 'は英数字を1文字以上ずつ入力してください' }
  validates :nickname, presence: true
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は全角の漢字・ひらがな・カタカナで入力してください' }
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は全角の漢字・ひらがな・カタカナで入力してください' }
  validates :first_kana_name, presence: true, format: { with: /\A[ァ-ンー]+\z/, message: 'は全角のカタカナで入力してください' }
  validates :family_kana_name, presence: true, format: { with: /\A[ァ-ンー]+\z/, message: 'は全角のカタカナで入力してください' }
  validates :birth_day, presence: true
end
