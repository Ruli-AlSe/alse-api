require 'rails_helper'

RSpec.describe V1::JobsController, type: :controller do
  describe 'Create job' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:job_info) {
      { title: Faker::Job.title,
        location: "#{Faker::Address.city}, #{Faker::Address.country}",
        job_type: :full_time,
        company_name: Faker::Company.name,
        start_date: '2020-01-01',
        end_date: '2024-11-01',
        activities: Array.new(5, Faker::Quote.famous_last_words) }
    }

    context 'Job registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { job: job_info })
      end

      context 'response with status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct job structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :title, :location, :job_type, :company_name, :start_date,
                                 :end_date, :activities, :profile_id, :created_at, :updated_at)
        }
        it { expect(subject[:title]).to eq(job_info[:title]) }
      end
    end

    context 'job not registered' do
      before do
        job_info[:title] = ''
        request.headers.merge!(headers)
        post(:create, format: :json, params: { job: job_info })
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
        post(:create, format: :json, params: { job: job_info })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
