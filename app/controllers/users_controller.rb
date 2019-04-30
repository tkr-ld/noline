class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy, :my_reservation]
  before_action :set_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}を削除しました。」"
  end

  def my_reservation
    @reservations = current_user.reservations.yet
  end

  def my_reserved_shop
    @shops = current_user.reserved_shops.page(params[:page]).per(4)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    unless current_user == User.find(params[:id])
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
   end
end
