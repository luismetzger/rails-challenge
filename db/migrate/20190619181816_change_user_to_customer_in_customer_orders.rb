class ChangeUserToCustomerInCustomerOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :customer_orders, :user
  end
end
