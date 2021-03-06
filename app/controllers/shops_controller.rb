class ShopsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy, :reset]
  before_action :set_shop, only: [:edit, :update, :destroy, :reset]
  before_action :shop_owner_or_redirect, only: [:show, :entered, :canceled]

  def index
    @q = Shop.where.not(user_id: current_user.id).ransack(params[:q])
    @shops = @q.result(distinct: true).page(params[:page]).per(12)
  end

  def my_shop
    @q = Shop.where(user_id: current_user.id).ransack(params[:q])
    @shops = @q.result(distinct: true).page(params[:page]).per(12)
  end

  def show
  end

  def entered
  end

  def canceled
  end

  def new
    @shop = Shop.new
    @reservation = Reservation.new
  end

  def create
    @shop = current_user.shops.new(shop_params)
    if @shop.save
      redirect_to shop_url(@shop), notice: "#{@shop.name}を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to shop_url(@shop), notice: "#{@shop.name}を更新しました"
    else
      render :new
    end
  end

  def destroy
    @shop.destroy
    redirect_to my_shop_shops_url, notice: "#{@shop.name}を削除しました"
  end

  def reset
    @shop.delete_all_reservation
    redirect_to shop_url(@shop), notice: "#{@shop.name}の予約状況をリセットしました"
  end

  private

  def correct_user
    unless current_user.shops.find_by(id: params[:id])
      redirect_to root_url
    end
  end

  def set_shop
    @shop = current_user.shops.find(params[:id])
  end

  def shop_owner_or_redirect
    @shop = Shop.find(params[:id])
    unless current_user.shops.find_by(id: params[:id])
      redirect_to new_shop_reservation_path(@shop)
    else
      @reservations = @shop.reservations.order('reserve_on desc')
    end
  end

  def shop_params
    params.require(:shop).permit(:name, :place, :image, :wait_time)
  end
end
