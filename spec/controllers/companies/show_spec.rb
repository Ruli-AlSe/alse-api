require 'rails_helper'

RSpec.describe V1::CompaniesController, type: :controller do
  let(:user) { create(:owner) }
  let(:bearer) { create(:token, user: user) }
  let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
  let(:companies) { create_list(:company, 5) }

  context 'Get user company by id' do
    before do
      request.headers.merge!(headers)
      get(:show, format: :json, params: { id: user.company.id })
    end

    context 'successful response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'correct structure of company' do
      subject { payload_test }

      it { is_expected.to include(:id, :name) }
    end
  end

  context 'Get other user company by id' do
    before do
      request.headers.merge!(headers)
      get(:show, format: :json, params: { id: rand(2..companies.size) })
    end

    context 'response with status unauthorized' do
      subject { response }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  context 'get company without access token' do
    before do
      get(:show, format: :json, params: { id: user.company.id })
    end

    context 'response with status unauthorized' do
      subject { response }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
