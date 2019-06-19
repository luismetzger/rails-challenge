class ChangeUserIdToCustomerIdInCustomerOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :customer_orders, :user_id, :customer_id
  end
end
