class Shop < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :wait_time, presence: true

  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :already_relationships, dependent: :destroy
  has_many :reserved_users, through: :already_relationships, source: :user

  def self.ransackable_attributes(auth_object = nil)
    %w[name place created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def set_expected
    DateTime.now + Rational(wait_time, 24 * 60)
  end

  def total_people_number
    n = 0
    reservations.yet.each do |reservation|
      n += reservation.people_number
    end
    n
  end

  def delete_all_reservation
    reservations.destroy_all
  end

end
