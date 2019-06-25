class Api::V1::CustomerOrdersController < ApiController

  def create
    check_required_params(params)
    customer = Customer.find_by_id(params[:customer_id])

    if customer.present?
      order = CustomerOrder.create(customer_id: params[:customer_id], total_cost: 0)
      variants = params[:variant_ids]
      order_variants(order, variants)
    else
      render json: {status: "error", code: 404, message: "id: #{params[:customer_id]} is an invalid customer_id"}
    end
  end

  private

  def order_variants(order, variants)
    variants.each do |variant|
      variant_record = Variant.find_by_id(variant[:variant_id])
      check_variant_params(variant)
      if variant_record.present?
        old_variant_stock =  variant_record.stock_amount
        if variant[:variant_quantity] > 0 && variant[:variant_quantity] <= variant_record.stock_amount
          order.total_cost = order.total_cost + variant_record.cost * variant[:variant_quantity]
          order.save
          variant_record.stock_amount = variant_record.stock_amount - variant[:variant_quantity]
          variant_record.save

          VariantOrder.create(variant_id: variant[:variant_id], variant_quantity: variant[:variant_quantity], customer_order_id: order.id)
        else
          variant_record.stock_amount = old_variant_stock
          variant_record.save
          render json: {status: "error", code: 422, message: "Not enough stock for variant_id #{variant[:variant_id]}"}
          return
        end
      else
        render json: {status: "error", code: 404, message: "variant_id: #{variant[:variant_id]} is invalid"}
        return
      end
    end

    render json: {status: "success", code: 200, message: "Order created successfully"}
  end
end