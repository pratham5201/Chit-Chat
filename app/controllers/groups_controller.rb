class GroupsController < ApplicationController
  before_action :find_group, only: %i[show update edit destroy]
  # before_action :set_query
  def index
    # debugger
    if params[:q]
      @query = Group.ransack(params[:q])
      @searched = @query.result(distinct: true)
    end
    
    if @searched
      @groups = @searched
    else
      @groups = Group.all
    end

  end

  def show
    @chat = Chat.new
    @users = User.all
    @searched = []
    @chats = Chat.where(group_id: params[:id])
    # debugger
    @id = params[:id]

    @chat.group_id = params[:id]
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

    if params[:page].blank?
      @chats = Chat.paginate(page: total_pages, per_page: 16).order('created_at ASC').where(group_id: params[:id])
    else
      @chats = Chat.paginate(page: params[:page], per_page: 16).order('created_at ASC').where(group_id: params[:id])
    end
  
    if params["format"]
      @id = params["format"].to_i
      @chat = Chat.find(@id)
    end
    
  end

  def create
    debugger
    @group = Group.create(group_params)
    @group.user_ids = current_user.id
    if @group.save
      format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
      format.json { render :show, status: :created, location: @group }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @group.errors, status: :unprocessable_entity }
    end
  end
  
  def update
    # debugger
    @chat = Chat.new
    @chat.message = params[:group][:message]
    @chat.user_id = current_user.id
    @chat.group_id = params[:id]
    @chat.username = current_user.email.split("@")[0].capitalize() || 'Guest'
    if @chat.save
      # debugger
      # redirect_to group_url(@group)
      redirect_to group_url(@group)
    end
    # respond_to do |format|
    #   if @chat.save
    #     format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
    #     format.json { render :show, status: :ok, location: @group }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @group.errors, status: :unprocessable_entity }
    #   end
    # end
    
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def destroy
    @group.destroy
    redirect_to root_path, notice: 'group was successfully destroyed.'
  end

  # def set_query
  #   @query = Group.ransack(params[:q])
  # end
  private

    def find_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :description, :message, :username)
    end
end