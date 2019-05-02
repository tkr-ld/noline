class ReservationMailer < ApplicationMailer
  def inform_change_time(reservation, user)
    @user = user
    @reservation = reservation

    mail(
      subject: "#{@reservation.shop.name}の予約時間が変更されました",
      to: @user.email
    )
  end
end
