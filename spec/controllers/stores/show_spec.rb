require 'rails_helper'

RSpec.describe V1::StoresController, type: :controller do
  let(:user) { create(:owner) }
  let(:bearer) { create(:token, user: user) }
  let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
  let(:stores) { create_list(:store, 5) }

  context 'Get user store by id' do
    before do
      request.headers.merge!(headers)
      get(:show, format: :json, params: { id: user.store.id })
    end

    context 'successful response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'correct structure of store' do
      subject { payload_test }

      it { is_expected.to include(:id, :name)}
    end
  end

  context 'Get other user store by id' do
    before do
      request.headers.merge!(headers)
      get(:show, format: :json, params: { id: rand(2..stores.size) })
    end

    context 'response with status unauthorized' do
      subject { response }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  context 'get store without access token' do
    before do
      get(:show, format: :json, params: { id: user.store.id })
    end

    context 'response with status unauthorized' do
      subject { response }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
