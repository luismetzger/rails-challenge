class Api::V1::CustomerOrdersController < ApiController
  def create
    check_required_params(params)
    begin
      customer = Customer.find(params[:customer_id])
      @order = CustomerOrder.create(customer_id: customer.id, total_cost: 0, order_status: "processing")
      variants = params[:variant_ids]

      variants.each do |variant|
        check_variant_params(variant)
        variant_record_exists?(variant[:variant_id])
        if variant[:variant_quantity].to_i.positive? && variant[:variant_quantity].to_i <= @variant_record.stock_amount
          @order.update(total_cost: (@order.total_cost + @variant_record.cost) * variant[:variant_quantity].to_i)
          VariantOrder.create(variant_id: variant[:variant_id], variant_quantity: variant[:variant_quantity].to_i, customer_order_id: @order.id)
          @variant_record.update(stock_amount: @variant_record.stock_amount - variant[:variant_quantity].to_i)
        else
          # raise OutOfStock
          # render json: { status: 422, message: "Not enough stock for variant_id #{variant[:variant_id]}" }
          p "Not enough stock for variant_id #{variant[:variant_id]}"
        end
      end
      render json: { data: {
          order: @order,
          status: 200,
          message: 'Order has been created.'
      } }
    rescue ActiveRecord::RecordNotFound => e
      render json: { status: 404, message: 'customer_id not is not valid.' }
    end
  end
end