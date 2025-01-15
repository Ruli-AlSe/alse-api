require 'rails_helper'

RSpec.describe V1::ProfilesController, type: :controller do
  let(:user) { create(:owner) }
  let(:user_profile) { create(:profile, profilable: user) }
  let(:bearer) { create(:token, user: user) }
  let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
  let(:other_user) { create(:owner) }
  let(:other_profile) { create(:profile, profilable: other_user) }

  context 'Get user profile by id' do
    before do
      request.headers.merge!(headers)
      get(:show, format: :json, params: { id: user_profile.id })
    end

    context 'successful response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'correct profile structure' do
      subject { payload_test }

      it {
        is_expected.to include(:id, :name, :last_name, :headliner, :bio, :city, :state, :country, :phone_number,
                               :social_media, :skills)
      }
    end
  end

  context 'Get profile of other user by id' do
    before do
      request.headers.merge!(headers)
      get(:show, format: :json, params: { id: other_profile.id })
    end

    context 'response with status unauthorized' do
      subject { response }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  context 'get profile without access token' do
    before do
      get(:show, format: :json, params: { id: user_profile.id })
    end

    context 'response with status unauthorized' do
      subject { response }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
