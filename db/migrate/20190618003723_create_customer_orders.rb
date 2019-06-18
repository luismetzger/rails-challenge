class CreateCustomerOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_orders do |t|
      t.decimal :total_cost, precision: 5, scale: 2
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
