require 'rails_helper'

RSpec.describe V1::SkillsController, type: :controller do
  describe 'Create skill' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let(:category) { create(:category, company: user.company) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:skill_info) {
      { name: Faker::ProgrammingLanguage.name,
        icon_url: Faker::Avatar.image,
        level: :basic,
        category_id: category.id }
    }

    context 'Skill registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { skill: skill_info })
      end

      context 'response with status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct skill structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :name, :icon_url, :level, :category, :created_at, :updated_at) }
        it { expect(subject[:category][:id]).to eq(category.id) }
      end
    end

    context 'Category not registered' do
      before do
        skill_info[:name] = ''
        request.headers.merge!(headers)
        post(:create, format: :json, params: { skill: skill_info })
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
        post(:create, format: :json, params: { skill: skill_info })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
