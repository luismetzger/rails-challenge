class Api::V1::CustomerOrdersController < ApiController
  before_action :find_customer, only: :create
  before_action :find_order, only: :show

  def show
    if @order.present?
      render json: order_response(@order)
    else
      render json: { status: 400, message: "Order not found." }
    end
  end

  def create
    check_required_params(params)
    if @customer.present?
      order = CustomerOrder.create(customer_id: params[:customer_id], total_cost: 0)
      variants = params[:variant_ids]
      order_variants(order, variants)
    else
      render json: {status: 404, message: "id: #{params[:customer_id]} is an invalid customer_id"}
    end
  end

  private

  def find_customer
    @customer = Customer.find_by_id(params[:customer_id])
  end

  def order_variants(order, variants)
    variants.each do |variant|
      variant_record = Variant.find_by_id(variant[:variant_id])
      check_variant_params(variant)
      if variant_record.present?
        if variant[:variant_quantity].to_i > 0 && variant[:variant_quantity].to_i <= variant_record.stock_amount
          order.update(total_cost: order.total_cost + variant_record.cost * variant[:variant_quantity].to_i)
          variant_record.update(stock_amount: variant_record.stock_amount - variant[:variant_quantity].to_i)
          VariantOrder.create(variant_id: variant[:variant_id], variant_quantity: variant[:variant_quantity], customer_order_id: order.id)
        else
          render json: {status: 422, message: "Not enough stock for variant_id #{variant[:variant_id]}"}
          return
        end
      else
        render json: {status: 404, message: "variant_id: #{variant[:variant_id]} is invalid"}
        return
      end
    end

    render json: {status: 200, message: "Order created successfully"}
  end

  def find_order
    @order = CustomerOrder.find_by_id(params[:id])
  end

  def order_response(order)
    order.to_json(
        only:    [:id, :user_id, :order_status, :total_cost, :created_at, :updated_at],
        include: {
            variant_orders:       {
                only:    [:variant_id, :variant_quantity],
                include: {
                    variant: {
                        only: [:id, :name, :cost]
                    }
                }
            }
        }
    )
  end
end