FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :customer do
    name { 'John Doe' }
    email { generate :email }
  end

  factory :product do
    name { 'T-Shirts' }
  end

  factory :variant do
    association :product
    name { 'Large' }
    cost { 10 }
    stock_amount { 100 }
    weight { 2.5 }
  end

  factory :variant_order do
    association :variant, :customer_order
    variant_quantity { 1 }
  end

  factory :customer_order do
    association :customer
    total_cost { 10 }
    order_status { "pending" }
  end
end