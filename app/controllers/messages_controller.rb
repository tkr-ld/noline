class MessagesController < ApplicationController
  def index
    @messages = current_user.messages.page(params[:page]).per(4)
  end
end
