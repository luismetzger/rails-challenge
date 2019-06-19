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

      it 'creates new order' do
        expect(valid_params[:customer_id]).to eq(customer.id)
        expect(valid_params[:variant_ids][0][:variant_id]).to eq(variant_1.id)
        expect(valid_params[:variant_ids][0][:variant_quantity]).to eq("2")
        expect(valid_params[:variant_ids][1][:variant_id]).to eq(variant_2.id)
        expect(valid_params[:variant_ids][1][:variant_quantity]).to eq("3")
        expect(valid_params[:variant_ids][2][:variant_id]).to eq(variant_3.id)
        expect(valid_params[:variant_ids][2][:variant_quantity]).to eq("4")
      end

      it 'returns status of 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request has missing params' do
      before { post '/api/v1/create_order', params: { "customer_id": customer.id } }

      it 'returns status of 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end