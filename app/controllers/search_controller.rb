class SearchController < ApplicationController
  def index
    @query = Chat.ransack(params[:q])
    @chat = @query.result(distinct: true)
  end
end