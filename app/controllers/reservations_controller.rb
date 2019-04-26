class ReservationsController < ApplicationController
  before_action :different_user, only: [:new, :show]

  def new
    @shop = Shop.find(params[:shop_id])
    reservation = current_user.reservations.find_by(shop_id: params[:shop_id])
    if reservation
      redirect_to shop_reservation_path(@shop, reservation)
    end
    @reservation = Reservation.new
  end

  def show
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

  def different_user
    if current_user.shops.find_by(id: params[:shop_id])
      redirect_to root_url
    end
  end
end
