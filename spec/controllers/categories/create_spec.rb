require 'rails_helper'

RSpec.describe V1::CategoriesController, type: :controller do
  describe 'Create category' do
    let(:user) { create(:owner_company_categories) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:category_info) {
      { title: Faker::Book.title,
        description: Faker::Lorem.sentence(word_count: 50),
        slug: Faker::Book.title.parameterize }
    }

    context 'Category registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { category: category_info })
      end

      context 'response with status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct category structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :title, :description, :slug, :company_id) }
      end
    end

    context 'Category not registered' do
      before do
        category_info[:title] = ''
        request.headers.merge!(headers)
        post(:create, format: :json, params: { category: category_info })
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

    context 'post request without token' do
      before do
        post(:create, format: :json, params: { category: category_info })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
