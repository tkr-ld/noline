class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :wait_time, presence: true

  belongs_to :user
  has_many :reservations
end
