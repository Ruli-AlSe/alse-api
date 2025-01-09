require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  describe 'Create product' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:product) {
      { name: Faker::Book.title,
        description: Faker::Lorem.sentence(word_count: 50),
        price: rand(10..100) }
    }

    context 'Product registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { product: product })
      end

      context 'response with status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct product structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :name, :description, :price, :store_id, :created_at, :updated_at) }
      end
    end

    context 'Product not registered' do
      before do
        product[:name] = ''
        request.headers.merge!(headers)
        post(:create, format: :json, params: { product: product })
      end

      context 'response with status bad request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'response with correct errors structure' do
        subject { payload_test }
        it { is_expected.to include(:errors) }
      end
    end

    context 'register product without token' do
      before do
        post(:create, format: :json, params: { product: product })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
