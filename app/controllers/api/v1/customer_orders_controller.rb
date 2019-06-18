class Api::V1::CustomerOrdersController < ApiController
  def create
    render json: { data: { status: 200 } }
  end
end