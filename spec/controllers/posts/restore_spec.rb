require 'rails_helper'

RSpec.describe V1::PostsController, type: :controller do
  describe 'Restore a post' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:post) { create(:post, company: user.company) }

    context 'post restored successfully' do
      before do
        post.destroy
        request.headers.merge! headers
        delete(:restore, format: :json, params: { post_id: post.id })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with post restored' do
        subject { payload_test }
        it { is_expected.to include(id: post.id) }
        it { is_expected.to include(:id, :title, :content, :credits, :company_id, :created_at, :updated_at) }
      end
    end

    context 'restore post without token' do
      before do
        post.destroy
        delete(:destroy, format: :json, params: { id: post.id })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
