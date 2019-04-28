class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :shops, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :already_relationships, dependent: :destroy
  has_many :reserved_shops, through: :already_relationships, source: :shop
end
