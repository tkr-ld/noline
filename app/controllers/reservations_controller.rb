class ReservationsController < ApplicationController
  before_action :different_user, only: [:new, :show]

  def new
    @shop = Shop.find(params[:shop_id])
    reservation = current_user.reservations.find_by(shop_id: params[:shop_id])
    #未予約か予約をキャンセルした場合のみ、予約できるようにする
    if reservation && !(reservation.cancel?)
      redirect_to shop_reservation_path(@shop, reservation)
    end
    @reservation = Reservation.new
  end

  def show
    @shop = Shop.find(params[:shop_id])
    @reservation = current_user.reservations.find(params[:id])
  end

  def create
    shop = Shop.find(params[:shop_id])
    reservation = current_user.reservations.new(reservation_params)
    reservation.reserve(shop)
    reservation.save!
    redirect_to root_url, notice: "#{shop.name}の予約を#{reservation.reserve_on.to_s(:ja)}で予約をお取りしました"
  end

  def cancel
    reservation = current_user.reservations.find(params[:reservation_id])
    reservation.cancel!
    redirect_to root_url, notice: "#{reservation.shop.name}の予約をキャンセルしました"
  end

  def enter
    reservation = Reservation.find(params[:reservation_id])
    reservation.enter!
    redirect_to shop_path(reservation.shop), notice: "#{reservation.user.name}が入店しました"
  end

  private

  def reservation_params
    params.require(:reservation).permit(:people_number)
  end

  def correct_user
  end

  def different_user
    if current_user.shops.find_by(id: params[:shop_id])
      redirect_to root_url
    end
  end
end
