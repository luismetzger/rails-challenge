class CreateVariantOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :variant_orders do |t|
      t.references :variant, foreign_key: true
      t.integer :variant_quantity
      t.references :customer_order, foreign_key: true

      t.timestamps
    end
  end
end
