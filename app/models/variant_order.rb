class VariantOrder < ApplicationRecord
  belongs_to :variant
  belongs_to :customer_order
end
