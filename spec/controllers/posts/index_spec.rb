require 'rails_helper'

RSpec.describe V1::PostsController, type: :controller do
  describe 'Products listing' do
    let(:user) { create(:owner) }
    let!(:posts_list) { create_list(:post, 5, company: user.company) }

    context 'get all posts correctly' do
      before do
        get(:index, format: :json, params: { email: user.email })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'correct structure of response' do
        subject { payload_test }
        it { is_expected.to include(:posts) }
        it { expect(subject[:posts].count).to eq(posts_list.count) }
        it { expect(subject[:posts].first[:id]).to eq(posts_list.first.id) }
      end
    end

    context 'get posts with incorrect email' do
      before do
        get(:index, format: :json, params: { email: 'incorrect@email.com' })
      end

      context 'response with status not_found' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end
  end
end
