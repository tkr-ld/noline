class ReservationsController < ApplicationController
  before_action :different_user, only: [:new, :show]
  before_action :set_shop, only: [:new, :show, :create]

  def index
    @reservations = current_user.reservations.yet
  end

  def new
    reservation = current_user.reservations.yet.find_by(shop_id: params[:shop_id])
    #未予約か予約をキャンセルした場合のみ、予約できるようにする
    if reservation
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
    unless current_user.reserved?(@shop)
      current_user.add_reserved_shop(@shop)
    end
    redirect_to root_url, notice: "#{@shop.name}の予約を#{reservation.reserve_on.to_s(:ja)}で予約をお取りしました"
  end

  def update
    reservation = Reservation.find(params[:id])
    reservation.update!(change_time_params)
    redirect_to shop_path(reservation.shop), notice: "#{reservation.user.name}さんの予約時間を#{reservation.reserve_on.to_s(:ja)}に変更しました"
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

  def change_time_params
    params.require(:reservation).permit(:reserve_on)
  end
end
