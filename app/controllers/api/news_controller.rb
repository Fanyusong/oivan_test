class Api::NewsController < ApplicationController
  def index
    data = NewsService.instance.read params[:page], params[:per_page]
    json_response({ data: data})
  end

  def show
    data = NewsService.instance.find_by_id params[:id]
    json_response({ data: data})
  end

  private

  def json_response data = {},  status = :ok
    render json: data, status: status
  end
end