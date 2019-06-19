class Api::V1::CustomerOrdersController < ApiController

  def create
    if params[:customer_id].present? && params[:variant_ids].present?
      customer = Customer.find_by(id: params[:customer_id])
      render json: { data: {
                              customer: customer,
                              message: "Order has been created.",
                              status: 200
                           }
                   }
    else
      render json: {status: 400, message: "Required parameter is missing"}
    end
  end
end