require 'rails_helper'

RSpec.describe V1::JobsController, type: :controller do
  describe 'Update job' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let(:job) { create(:job, profile: user_profile) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:job_info) {
      { title: 'title updated',
        location: 'location updated',
        activities: Array.new(2, Faker::Quote.famous_last_words) }
    }

    context 'Job updated successfully' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: job.id, job: job_info })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with correct job structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :title, :location, :job_type, :company_name, :start_date, :skills,
                                 :end_date, :activities, :profile_id, :created_at, :updated_at)
        }
        it { expect(subject[:title]).to eq(job_info[:title]) }
        it { expect(subject[:activities].count).to eq(job_info[:activities].count) }
      end
    end

    context 'unsuccessful response' do
      before do
        job_info[:title] = ''
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: job.id, job: job_info })
      end

      context 'with status bad_request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'with correct errors structure' do
        subject { payload_test }
        it { is_expected.to include(:errors) }
      end
    end

    context 'unsuccessful response due to incorrect job id' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: 0, job: job_info })
      end

      context 'with status not_found' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end

    context 'send request without token' do
      before do
        put(:update, format: :json, params: { id: job.id, job: job_info })
      end

      context 'with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
