class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :wait_time, presence: true

  belongs_to :user
  has_many :reservations

  def set_expected
    DateTime.now + Rational(wait_time, 24 * 60)
  end

  def delete_all_reservation
    reservations.destroy_all
  end
end
