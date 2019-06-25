require "rails_helper"

describe Customer do
  let(:customer) { FactoryBot.create(:customer) }

  it "creates a new record" do
    expect(customer).to be_valid
  end

  it "is not valid without a name" do
    customer.update(name: nil)
    expect(customer).to_not be_valid
  end

  it "is not valid without an email" do
    customer.update(email: nil)
    expect(customer).to_not be_valid
  end
end