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

  def divide_time
    diff_time = ( reserve_on - DateTime.now ) / 60
    if diff_time < 0
      "red"
    elsif diff_time < 10
      "blue"
    else
      "normal"
    end
  end
end
