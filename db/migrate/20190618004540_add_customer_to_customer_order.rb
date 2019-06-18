class AddCustomerToCustomerOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :customer_orders, :user, foreign_key: true
  end
end
