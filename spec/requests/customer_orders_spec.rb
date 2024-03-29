require 'rails_helper'

describe 'Customer Orders API', type: :request do
  let!(:customer) { FactoryBot.create(:customer) }
  let!(:variant_1) { FactoryBot.create(:variant) }
  let!(:variant_2) { FactoryBot.create(:variant) }
  let!(:variant_3) { FactoryBot.create(:variant) }
  let(:variant_ids_array) { [ {
                                 "variant_id": variant_1.id,
                                 "variant_quantity": 1
                             },
                             {
                                 "variant_id": variant_2.id,
                                 "variant_quantity": 3
                             },
                             {
                                 "variant_id": variant_3.id,
                                 "variant_quantity": 4
                             } ] }

  describe 'POST /api/v1/create_order' do
    let(:valid_params) { { "customer_id": customer.id,
                           "variant_ids": variant_ids_array } }

    context 'when the request is valid' do
      before { post '/api/v1/create_order', params: valid_params }

      it 'creates new order' do
        expect(valid_params[:customer_id]).to eq(customer.id)
        expect(valid_params[:variant_ids][0][:variant_id]).to eq(variant_1.id)
        expect(valid_params[:variant_ids][0][:variant_quantity]).to eq(1)
        expect(valid_params[:variant_ids][1][:variant_id]).to eq(variant_2.id)
        expect(valid_params[:variant_ids][1][:variant_quantity]).to eq(3)
        expect(valid_params[:variant_ids][2][:variant_id]).to eq(variant_3.id)
        expect(valid_params[:variant_ids][2][:variant_quantity]).to eq(4)
      end

      it 'returns status of 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when request has missing variant_ids param' do
      before { post '/api/v1/create_order', params: { "customer_id": customer.id } }

      it 'returns status of 400' do
        expect(JSON.parse(response.body)['status']).to eq(400)
      end
    end

    context 'when request has missing customer_id param' do
      before { post '/api/v1/create_order', params: { "variant_ids": variant_ids_array } }

      it 'returns status of 400' do
        expect(JSON.parse(response.body)['status']).to eq(400)
      end
    end

    context 'when request cannot find customer_id' do
      before { post '/api/v1/create_order', params: { "customer_id": 2, "variant_ids": variant_ids_array } }

      it 'returns status of 404' do
        expect(JSON.parse(response.body)['status']).to eq(404)
      end
    end
  end
end