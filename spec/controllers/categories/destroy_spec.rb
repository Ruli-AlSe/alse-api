require 'rails_helper'

RSpec.describe V1::CategoriesController, type: :controller do
  describe 'Delete a category' do
    let(:user) { create(:owner_company_categories) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }

    context 'category removed successfully' do
      before do
        request.headers.merge!(headers)
        delete(:destroy, format: :json, params: { id: user.company.categories.first.id })
        user.reload
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
        it { expect(user.company.categories.count).to eq(2) }
      end
    end

    context 'remove category not found' do
      before do
        request.headers.merge!(headers)
        delete(:destroy, format: :json, params: { id: 0 })
      end

      context 'response with status not found' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end

    context 'delete request without token' do
      before do
        delete(:destroy, format: :json, params: { id: user.company.categories.first.id })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
