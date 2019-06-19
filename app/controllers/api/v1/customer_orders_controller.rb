class Api::V1::CustomerOrdersController < ApiController

  def create
    customer = Customer.find_by(id: params[:customer_id])

    if customer.present?
      render json: { data: {
                              customer: customer,
                              message: "Order has been created.",
                              status: 200
                           }
                   }
    else
      render json: { errors: ["customer_id not present."] }
    end
  end
end