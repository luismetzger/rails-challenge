require 'rails_helper'

describe CustomerOrder do
  let(:customer_order) { FactoryBot.create(:customer_order) }

  it "creates a new record" do
    expect(customer_order).to be_valid
  end

  it 'is not valid without a customer_id' do
    customer_order.update(customer_id: nil)

    expect(customer_order).to_not be_valid
  end

  it 'is not valid without an integer' do
    customer_order.update(total_cost: nil)
    expect(customer_order).to_not be_valid
  end
end
