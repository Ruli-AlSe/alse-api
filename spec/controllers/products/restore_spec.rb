require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  describe 'Restore a product' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:product) { create(:product, company: user.company) }

    context 'product restored successfully' do
      before do
        product.destroy
        request.headers.merge! headers
        delete(:restore, format: :json, params: { product_id: product.id })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with product restored' do
        subject { payload_test }
        it { is_expected.to include(id: product.id) }
        it { is_expected.to include(:id, :name, :price, :description, :company_id) }
      end
    end

    context 'restore product without token' do
      before do
        product.destroy
        delete(:destroy, format: :json, params: { id: product.id })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
