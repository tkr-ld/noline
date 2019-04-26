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
    redirect_to shops_url, notice: "#{shop.name}を登録しました"
  end

  def edit
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :place, :wait_time)
  end
end
