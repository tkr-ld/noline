class Reservation < ApplicationRecord
  validates :reserve_on, presence: true
  validates :people_number, presence: true

  enum status: { yet: 0, enter: 1, cancel: 2 }

  belongs_to :user
  belongs_to :shop

  def reserve(shop)
    self.shop_id = shop.id
    self.reserve_on = shop.set_expected
  end
end
