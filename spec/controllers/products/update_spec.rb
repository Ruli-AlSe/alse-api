require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  describe 'Update products' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:product) { create(:product, company: user.company) }

    context 'Product updated successfully' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: product.id, product: { name: 'New testing name' } })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with correct product structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :name, :description, :price, :company_id, :created_at, :updated_at) }
      end
    end

    context 'Product not updated' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: product.id, product: { name: '' } })
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

    context  'update product without token' do
      before do
        put(:update, format: :json, params: { id: product.id, product: { name: 'New testing name' } })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
