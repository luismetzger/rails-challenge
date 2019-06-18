class ChangeTotalCostToIntegerInCustomerOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :customer_orders, :total_cost, :integer
  end
end
