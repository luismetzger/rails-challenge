class Api::V1::CustomerOrdersController < ApiController
  def create
    if params[:customer_id].present? && params[:variant_ids].present?
      begin
        customer = Customer.find(params[:customer_id])
        order = CustomerOrder.create(user_id: customer.id, total_cost: 0, order_status: "processing")
        render json: { data: {
                                order: order,
                                status: 200,
                                message: 'Order has been created.'
                                } }
      rescue ActiveRecord::RecordNotFound => e
        render json: { status: 404, message: "customer_id not is not valid." }
      end
    else
      render json: { status: 400, message: 'Required parameter is missing' }
    end
  end
end