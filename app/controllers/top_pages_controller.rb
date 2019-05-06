class TopPagesController < ApplicationController
  skip_before_action :login_required

  def index
    if current_user
      redirect_to shops_path
    end
    @shops = Shop.all.page(params[:page]).per(4)
  end
end
