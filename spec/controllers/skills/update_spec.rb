require 'rails_helper'

RSpec.describe V1::SkillsController, type: :controller do
  describe 'Update skill' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let(:category) { create(:category, company: user.company) }
    let(:skill) { create(:skill, category: category, profile: user_profile) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:skill_info) {
      { name: 'name updated',
        level: :advanced,
        category_id: category.id }
    }

    context 'successful response' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: skill.id, skill: skill_info })
      end

      context 'with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'with correct skill structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :name, :icon_url, :level, :category) }
        it { expect(subject[:name]).to eq(skill_info[:name]) }
      end
    end

    context 'unsuccessful response' do
      before do
        skill_info[:name] = ''
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: skill.id, skill: skill_info })
      end

      context 'with status bad request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'with correct errors structure' do
        subject { payload_test }
        it { is_expected.to include(:errors) }
      end
    end

    context 'send request without token' do
      before do
        put(:update, format: :json, params: { id: skill.id, skill: skill_info })
      end

      context 'with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
