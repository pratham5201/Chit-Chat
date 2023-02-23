class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_query
    
    def set_query
        @query = Chat.ransack(params[:q])
    end
end
