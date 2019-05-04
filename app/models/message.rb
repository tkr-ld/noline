class Message < ApplicationRecord
  validates :content_type, presence: true
  validates :content_type, presence: true

  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  def cancel(reservation)
    self.content_type = 0
    self.content = "#{reservation.user.name}さんがあなたのお店#{reservation.shop.name}の#{reservation.reserve_on.to_s(:ja)}の予約をキャンセルしました"
  end

  def reserve(reservation)
    self.content_type = 1
    self.content = "#{reservation.user.name}さんがあなたのお店#{reservation.shop.name}の予約を#{reservation.reserve_on.to_s(:ja)}で取りました"
  end

  def change_reservation_time(reservation)
    self.content_type = 2
    self.content = "#{reservation.shop.name}の予約時間が#{reservation.reserve_on.to_s(:ja)}に変更されました"
  end
end
