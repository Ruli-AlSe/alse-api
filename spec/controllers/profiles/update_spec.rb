require 'rails_helper'

RSpec.describe V1::ProfilesController, type: :controller do
  describe 'Update profile action' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:user_profile) { create(:profile, profilable: user) }
    let(:category) { create(:category, company: user.company) }
    let(:skill) { create(:skill, category: category, profile: user_profile) }

    context 'when has been updated successfully' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json,
                     params: { id: user_profile.id, profile: { name: 'New testing name', 
                                                               headliner: 'New testing headliner' } })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with correct profile structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :name, :last_name, :headliner, :bio, :city, :state, :country, :phone_number,
                                 :social_media, :skills)
        }
      end
    end

    context 'when has been updated successfully with nested attributes for skills' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json,
                     params: { id: user_profile.id, profile: { name: 'New testing name', 
                                                               headliner: 'New testing headliner',
                                                               skills_attributes: [skill] } })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with correct profile structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :name, :last_name, :headliner, :bio, :city, :state, :country, :phone_number,
                                 :social_media, :skills)
        }
        it { expect(subject[:skills].first[:id]).to eq(skill.id) }
      end
    end

    context 'when something was wrong' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json,
                     params: { id: user_profile.id, profile: { title: 'New testing title',
                                                               biography: 'New testing biography' } })
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

    context  'update profile without token' do
      before do
        put(:update, format: :json,
                     params: { id: user_profile.id, profile: { name: 'New testing name', headliner: 'New testing headliner' } })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
