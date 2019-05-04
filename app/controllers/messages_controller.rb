class MessagesController < ApplicationController
  def index
    current_user.update!(messages_yet_count: 0)
    @messages = current_user.messages.page(params[:page]).per(15)
  end
end
