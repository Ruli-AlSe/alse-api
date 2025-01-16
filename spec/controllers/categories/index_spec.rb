require 'rails_helper'

RSpec.describe V1::CategoriesController, type: :controller do
  describe 'Categories listing' do
    let(:user) { create(:owner_company_categories) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }

    context 'get all categories correctly' do
      before do
        request.headers.merge! headers
        get(:index, format: :json)
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'correct structure of response' do
        subject { payload_test }
        it 'includes a categories key' do
          expect(subject).to include(:categories)
        end

        it 'ensures categories is an array' do
          expect(subject[:categories]).to be_an(Array)
        end

        it 'ensures all elements in categories have correct company_id' do
          expect(subject[:categories]).to all(include(company_id: user.company_id))
        end
      end
    end

    context 'get categories without token' do
      before do
        get(:index, format: :json)
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
