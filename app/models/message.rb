class Message < ApplicationRecord
  validates :content_type, presence: true
  validates :content_type, presence: true

  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  def cancel(reservation)
    self.content_type = 0
    self.content = "#{reservation.user.name}さんがあなたのお店#{reservation.shop.name}の#{reservation.reserve_on.to_s(:ja)}の予約をキャンセルしました"
    user = reservation.shop.user
    add_count(user)
  end

  def reserve(reservation)
    self.content_type = 1
    self.content = "#{reservation.user.name}さんがあなたのお店#{reservation.shop.name}の予約を#{reservation.reserve_on.to_s(:ja)}で取りました"
    user = reservation.shop.user
    add_count(user)
  end

  def change_reservation_time(reservation)
    self.content_type = 2
    self.content = "#{reservation.shop.name}の予約時間が#{reservation.reserve_on.to_s(:ja)}に変更されました"
    user = reservation.user
    user = reservation.shop.user
    add_count(user)
  end

  private

  def add_count(user)
    user.messages_yet_count += 1
    user.save!
  end
end
