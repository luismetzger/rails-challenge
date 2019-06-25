class Variant < ApplicationRecord
  belongs_to :product
  has_one :variant_order
end
