require 'rails_helper'

RSpec.describe V1::CategoriesController, type: :controller do
  describe 'Update category' do
    let(:user) { create(:owner_company_categories) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:category) { create(:category, company: user.company) }

    context 'Category updated successfully' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json,
                     params: { id: category.id, category: { title: 'New testing name', slug: 'new-testing-name' } })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with correct category structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :title, :description, :slug, :company_id) }
        it { expect(subject[:title]).to eq('New testing name') }
        it { expect(subject[:slug]).to eq('new-testing-name') }
      end
    end

    context 'category not found' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json,
                     params: { id: 0, category: { title: 'New testing name', slug: 'new-testing-name' } })
      end

      context 'response with status not found' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end

    context 'Category not updated' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: category.id, category: { title: '' } })
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

    context 'put request without token' do
      before do
        put(:update, format: :json,
                     params: { id: category.id, category: { title: 'New testing name', slug: 'new-testing-name' } })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
