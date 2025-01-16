require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do
  describe 'Create project' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:project_info) {
      { name: Faker::App.name,
        description: Faker::Lorem.sentence,
        company_name: Faker::Company.name,
        live_url: Faker::Internet.url,
        repository_url: Faker::Internet.url }
    }

    context 'project registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { project: project_info })
      end

      context 'response with status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct project structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :name, :description, :company_name, :live_url, :repository_url, :company_id, :created_at, :updated_at) }
      end
    end

    context 'project not registered' do
      before do
        project_info[:name] = ''
        request.headers.merge!(headers)
        post(:create, format: :json, params: { project: project_info })
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

    context 'register project without token' do
      before do
        post(:create, format: :json, params: { project: project_info })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
