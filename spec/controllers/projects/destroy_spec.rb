require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do
  describe 'Delete project' do
    let(:user) { create(:owner) }
    let(:project) { create(:project, company: user.company) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }

    context 'project deleted successfully' do
      before do
        request.headers.merge!(headers)
        delete(:destroy, format: :json, params: { id: project.id })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end
    end

    context 'project not_found' do
      before do
        request.headers.merge!(headers)
        delete(:destroy, format: :json, params: { id: 0 })
      end

      context 'response with status bad request' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end

    context 'delete project without token' do
      before do
        delete(:destroy, format: :json, params: { id: project.id })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
