require 'rails_helper'

RSpec.describe V1::ProfilesController, type: :controller do
  let(:user) { create(:owner) }
  let!(:user_profile) { create(:profile, profilable: user) }
  let(:other_user) { create(:owner) }

  context 'Get user profile by email' do
    before do
      get(:show, format: :json, params: { email: user.email })
    end

    context 'successful response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'correct profile structure' do
      subject { payload_test }

      it {
        is_expected.to include(:id, :name, :last_name, :image_url, :about_me, :headliner, :bio, :city, :state,
                               :country, :phone_number, :social_media, :competences)
      }
      it { expect(subject[:id]).to eq(user_profile.id) }
    end
  end

  context 'Get non-existent user profile' do
    before do
      get(:show, format: :json, params: { email: other_user.email })
    end

    context 'response with status not_found' do
      subject { response }

      it { is_expected.to have_http_status(:not_found) }
    end
  end

  context 'Get profile of a non-existent user' do
    before do
      get(:show, format: :json, params: { email: 'false@email.com' })
    end

    context 'response with status not_found' do
      subject { response }

      it { is_expected.to have_http_status(:not_found) }
    end
  end
end
