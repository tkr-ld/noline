class ReservationsController < ApplicationController
  before_action :different_user, only: [:new, :show]
  before_action :set_shop, only: [:new, :show, :create]

  def new
    reservation = current_user.reservations.find_by(shop_id: params[:shop_id])
    #未予約か予約をキャンセルした場合のみ、予約できるようにする
    if reservation && !(reservation.cancel?)
      redirect_to shop_reservation_path(@shop, reservation)
    end
    @reservation = Reservation.new
  end

  def show
    @reservation = current_user.reservations.find(params[:id])
  end

  def create
    reservation = current_user.reservations.new(reservation_params)
    reservation.reserve(@shop)
    reservation.save!
    redirect_to root_url, notice: "#{@shop.name}の予約を#{reservation.reserve_on.to_s(:ja)}で予約をお取りしました"
  end

  def cancel
    unless reservation = current_user.reservations.find(params[:id])
      redirect_to root_url
    end
    reservation.cancel!
    redirect_to root_url, notice: "#{reservation.shop.name}の予約をキャンセルしました"
  end

  def enter
    reservation = Reservation.find(params[:id])
    reservation.enter!
    redirect_to shop_path(reservation.shop), notice: "#{reservation.user.name}が入店しました"
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def different_user
    if current_user.shops.find_by(id: params[:shop_id])
      redirect_to root_url
    end
  end

  def reservation_params
    params.require(:reservation).permit(:people_number)
  end
end
