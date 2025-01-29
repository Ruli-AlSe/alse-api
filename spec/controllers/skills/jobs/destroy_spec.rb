require 'rails_helper'

RSpec.describe V1::SkillsController, type: :controller do
  describe 'Delete skill in job' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let(:category) { create(:category, company: user.company) }
    let(:job) { create(:job, profile: user_profile) }
    let(:skill) { create(:skill, category: category, skillable: job) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }

    context 'skill removed successfully' do
      before do
        request.headers.merge! headers
        delete(:destroy, format: :json, params: { job_id: job.id, id: skill.id })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end
    end

    context 'skill not found' do
      before do
        request.headers.merge! headers
        delete(:destroy, format: :json, params: { job_id: job.id, id: 0 })
      end

      context 'response with status not found' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end

    context 'remove skill without token' do
      before do
        delete(:destroy, format: :json, params: { job_id: job.id, id: skill.id })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
