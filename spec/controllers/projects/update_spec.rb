require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do
  describe 'Update project' do
    let(:user) { create(:owner) }
    let(:project) { create(:project, company: user.company) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:project_info) {
      { name: 'name updated',
        description: 'description updated' }
    }

    context 'project updated successfully' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: project.id, project: project_info })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with correct project structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :name, :description, :company_name, :live_url, :repository_url, :skills,
                                 :company_id, :created_at, :updated_at)
        }
      end
    end

    context 'project not registered' do
      before do
        project_info[:name] = ''
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: project.id, project: project_info })
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

    context 'update project without token' do
      before do
        put(:update, format: :json, params: { id: project.id, project: project_info })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
