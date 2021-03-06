class MessagesController < ApplicationController
  #before_action :authenticate_user!
  # authorize! :action, Message, message => "You are not authorized"
  
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  
  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    #authorize! :action, Message, message => "You are not authorized"

    @message = Message.new(message_params)

    # implying that we actually have a currrent user which we don't
    @message.messagewriter = current_messagewriter

    @message.save
    # redirect_to request.referrer
    SendMessageJob.perform_later(@message)
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    authorize! :action, Message, message => "You are not authorized"

    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    #authorize! :action, Message, message => "You are not authorized"
    
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content, :messagewriter_id, :room_id)
    end
end
