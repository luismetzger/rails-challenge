class Customer < ApplicationRecord
  has_many :customer_orders

  validates_presence_of :name, :email
end
