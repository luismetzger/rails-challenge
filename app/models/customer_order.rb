class CustomerOrder < ApplicationRecord
  enum order_status: {
      pending: 0,
      processing: 1,
      fulfilled: 2,
      delivered: 3,
      cancelled: 4
  }
  belongs_to :customer
end
