class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # 年齢は必須入力かつ0以上
  validates :age , numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :update
  # 内容は必須入力かつ2文字以上30文字以下
  validates :address , length: { minimum: 2, maximum: 30 }, on: :update

  has_secure_password
end
