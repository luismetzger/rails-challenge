require 'rails_helper'

describe 'Customer Orders API', type: :request do
  describe 'POST /api/v1/create_order' do
    context 'when the request is valid' do
      before { post '/api/v1/create_order', params: "" }

      it 'returns status of 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end