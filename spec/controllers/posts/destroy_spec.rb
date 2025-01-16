require 'rails_helper'

RSpec.describe V1::PostsController, type: :controller do
  describe 'Delete a post' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:post) { create(:post, company: user.company) }

    context 'post removed successfully' do
      before do
        request.headers.merge! headers
        delete(:destroy, format: :json, params: { id: post.id })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end
    end

    context 'remove post without token' do
      before do
        delete(:destroy, format: :json, params: { id: post.id })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
