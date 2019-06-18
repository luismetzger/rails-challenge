require 'rails_helper'

describe 'Customer Orders API', type: :request do
  let!(:customer) { FactoryBot.create(:customer) }
  let!(:variant_1) { FactoryBot.create(:variant) }
  let!(:variant_2) { FactoryBot.create(:variant) }
  let!(:variant_3) { FactoryBot.create(:variant) }

  describe 'POST /api/v1/create_order' do
    let(:valid_params) {
                        {
                          "customer_id": customer.id,
                          "variant_ids": [
                                          {
                                              "variant_id": variant_1.id,
                                              "variant_quantity": "2"
                                          },
                                          {
                                              "variant_id": variant_2.id,
                                              "variant_quantity": "3"
                                          },
                                          {
                                              "variant_id": variant_3.id,
                                              "variant_quantity": "4"
                                          }
                                        ]
                        }
                      }

    context 'when the request is valid' do
      before { post '/api/v1/create_order', params: valid_params }

      it 'returns status of 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end