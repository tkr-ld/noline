class ReservationsController < ApplicationController
  def new
    @shop = Shop.find(params[:shop_id])
    @reservation = Reservation.new
  end

  def create
    shop = Shop.find(params[:shop_id])
    reservation = current_user.reservations.new(reservation_params)
    reservation.reserve(shop)
    reservation.save!
    redirect_to root_url, notice: "#{shop.name}の予約を#{reservation.reserve_on.to_s(:ja)}で予約をお取りしました"
  end

  private

  def reservation_params
    params.require(:reservation).permit(:people_number)
  end
end
