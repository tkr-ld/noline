class ShopsController < ApplicationController
  before_action :set_shop, only: [:edit, :update, :destroy]
  before_action :shop_owner?, only: [:show, :entered, :canceled]

  def index
    @shops = Shop.where.not(user_id: current_user.id)
  end

  def my_index
    @shops = Shop.where(user_id: current_user.id)
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
    shop.destroy
    redirect_to shops_url, notice: "#{shop.name}を削除しました"
  end

  private

  def set_shop
    @shop = current_user.shops.find(params[:id])
  end

  def shop_owner?
    @shop = Shop.find(params[:id])
    unless current_user.shops.find_by(id: params[:id])
      redirect_to new_shop_reservation_path(@shop)
    else
      @reservations = @shop.reservations.all
    end
  end

  def shop_params
    params.require(:shop).permit(:name, :place, :wait_time)
  end
end
