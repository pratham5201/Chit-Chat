class ChatsController < ApplicationController
  # before_action :authenticate_user!
  def index
    @chat = Chat.new
    @users = User.all
    @searched = []
    @chats = Chat.where(group_id: 4)
    # debugger

    @username = current_user.email.split("@")[0].capitalize() || 'Guest'
    @chat.username = current_user.email.split("@")[0].capitalize() || 'Guest'

    # If the page number isn't specified in the query parameters, show the last page
    
    if params[:q]
      @query = Chat.ransack(params[:q])
      @searched = @query.result(distinct: true)
      # debugger
    end

    total_pages = @chats.paginate(page: params[:page], per_page: 16).total_pages
    # debugger
    if params[:page].blank?
      @chats = Chat.paginate(page: total_pages, per_page: 16).order('created_at ASC').where(group_id: 4)
    else
      @chats = Chat.paginate(page: params[:page], per_page: 16).order('created_at ASC').where(group_id: 4)
    end
  
    if params["format"]
      @id = params["format"].to_i
      @chat = Chat.find(@id)
    end
    
    render :index, locals: { username: @username }
  end
  
  def new
    @chat = Chat.new
  end
  
  def create
    @chat = Chat.new(chat_params)
    @user = current_user
    @chat.user_id = current_user.id
    @chat.username = @user.email.split("@")[0].capitalize() || 'Guest'
    @chat.group_id = 4
    if @chat.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to root_path
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @chat.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to root_path, notice: 'Chat was successfully destroyed.'
  end

  def update_chat
    # debugger
    @id = params["format"].to_i
    @chat = Chat.find(@id)
    respond_to do |format|
      if @chat.update(chat_params_require)
        format.html { redirect_to chat_url(@chat), notice: "chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def chat_params
      params.require(:chat).permit(:username, :message)
    end

    def chat_params_require
      # debugger
      params.require(:chat).permit(:username, :message)
    end
end
