class ShopsController < ApplicationController
  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
    unless current_user.shops.find_by(id: params[:id])
      redirect_to new_shop_reservation_path(@shop)
    else
      @reservations = @shop.reservations.all
    end
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
    @shop = current_user.shops.find(params[:id])
  end

  def update
    @shop = current_user.shops.find(params[:id])
    if @shop.update(shop_params)
      redirect_to shop_url(@shop), notice: "#{@shop.name}を更新しました"
    else
      render :new
    end
  end

  def destroy
    @shop = current_user.shops.find(params[:id])
    shop.destroy
    redirect_to shops_url, notice: "#{shop.name}を削除しました"
  end

  private

  def match_user
    unless current_user.shops.find_by(id: params[:id])
    end
  end

  def shop_params
    params.require(:shop).permit(:name, :place, :wait_time)
  end
end
