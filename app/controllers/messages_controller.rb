class MessagesController < ApplicationController
    def index
      @messages = Message.last(3)
    end
  
    def home
      @messages = Message.last(3)
    end
  
    def create
      message = Message.new(content: message_params[:content])
      if message.save
        ActionCable.server.broadcast("messages_channel", { messages: Message.last(3) })
        respond_to do |format|
          format.js
          format.html { redirect_to messages_path }
        end
      else
        respond_to do |format|
          format.js { render js: "alert('Error saving message.');" }
          format.html { render :new }
        end
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:content) 
    end
end
