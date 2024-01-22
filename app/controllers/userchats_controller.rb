class UserchatsController < ApplicationController
  before_action :set_userchat, only: %i[ show edit update destroy ]

  # GET /userchats or /userchats.json
  def index
    # debugger
    @userchats = Userchat.all
    if $receiver && params[:format]
      @userchat = Userchat.find(params[:format])
    elsif params[:format] 
      $receiver = User.find(params[:format])
      @receiver_name  = $receiver.email.split("@")[0].capitalize() || 'Guest'
    end
   
    @userchat = Userchat.new
    @users = User.all
    @searched = []

    @username = current_user.email.split("@")[0].capitalize() || 'Guest'
    @userchat.username = current_user.email.split("@")[0].capitalize() || 'Guest'

    # If the page number isn't specified in the query parameters, show the last page
    
    if params[:q]
      @query = Userchat.ransack(params[:q])
      @searched = @query.result(distinct: true)
      # debugger
    end

    # total_pages = @userchats.paginate(page: params[:page], per_page: 16).total_pages
    # # debugger
    # if params[:page].blank?
    #   @userchats = Userchat.paginate(page: total_pages, per_page: 16).order('created_at ASC').where(group_id: 4)
    # else
    #   @userchats = Userchat.paginate(page: params[:page], per_page: 16).order('created_at ASC').where(group_id: 4)
    # end
  
    # if params["format"]
    #   @id = params["format"].to_i
    #   @chat = Userchat.find(@id)
    # end
    
    render :index, locals: { username: @username }

  end

  def fake_index

  end

  # GET /userchats/1 or /userchats/1.json
  def show

    
    @userchats = Userchat.all
    if params[:params
      $receiver = User.find(params[:format])
      @receiver_name  = $receiver.email.split("@")[0].capitalize() || 'Guest'
    end
   
    @userchat = Userchat.new
    @users = User.all
    @searched = []

    @username = current_user.email.split("@")[0].capitalize() || 'Guest'
    @userchat.username = current_user.email.split("@")[0].capitalize() || 'Guest'

    # If the page number isn't specified in the query parameters, show the last page
    
    if params[:q]
      @query = Userchat.ransack(params[:q])
      @searched = @query.result(distinct: true)
      # debugger
    end

    # total_pages = @userchats.paginate(page: params[:page], per_page: 16).total_pages
    # # debugger
    # if params[:page].blank?
    #   @userchats = Userchat.paginate(page: total_pages, per_page: 16).order('created_at ASC').where(group_id: 4)
    # else
    #   @userchats = Userchat.paginate(page: params[:page], per_page: 16).order('created_at ASC').where(group_id: 4)
    # end
  
    # if params["format"]
    #   @id = params["format"].to_i
    #   @chat = Userchat.find(@id)
    # end
    
    render :index, locals: { username: @username }

  end

  # GET /userchats/new
  def new
    @userchat = Userchat.new
  end

  # GET /userchats/1/edit
  def edit
    fake_index($receiver, @userchat)
  end

  # POST /userchats or /userchats.json
  def create
    # debugger
    @userchat = Userchat.new(userchat_params)
    @userchat.user_id = current_user.id
    @userchat.sender = current_user.id
    @userchat.username = current_user.email.split("@")[0].capitalize() || 'Guest'
    @userchat.receiver = $receiver.id
    
    if @userchat.save
      redirect_to userchats_path($receiver.id)
    end
  end

  # PATCH/PUT /userchats/1 or /userchats/1.json
  def update
    debugger
    @id = $receiver.id
    respond_to do |format|
      if @userchat.update(userchat_params)
        format.html { redirect_to userchat_url(@id), notice: "Userchat was successfully updated." }
        format.json { render :show, status: :ok, location: @userchat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @userchat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userchats/1 or /userchats/1.json
  def destroy
    @userchat.destroy
    @id = $receiver.id
    # debugger
    respond_to do |format|
      format.html { redirect_to userchats_url(@id), notice: "Userchat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userchat
      @userchat = Userchat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def userchat_params
      params.require(:userchat).permit(:message, :sender, :receiver, :user_id, :username)
    end
end

