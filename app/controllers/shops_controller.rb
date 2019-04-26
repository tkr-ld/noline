class ShopsController < ApplicationController
  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def new
    @shop = Shop.new
  end

  def create
    shop = Shop.new(shop_params)
    shop.save!
    redirect_to shop_url(shop), notice: "#{shop.name}を登録しました"
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    shop = Shop.find(params[:id])
    shop.update!(shop_params)
    redirect_to shop_url(shop), notice: "#{shop.name}を更新しました"
  end

  def destroy
    shop = Shop.find(params[:id])
    shop.destroy
    redirect_to shops_url, notice: "#{shop.name}を削除しました"
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :place, :wait_time)
  end
end
