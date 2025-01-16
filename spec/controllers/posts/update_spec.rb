require 'rails_helper'

RSpec.describe V1::PostsController, type: :controller do
  describe 'Update posts' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:post) { create(:post, company: user.company) }

    context 'Post updated successfully' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: post.id, post: { name: 'New testing name' } })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response with correct post structure' do
        subject { payload_test }
        it { is_expected.to include(:id, :title, :content, :credits, :company_id, :created_at, :updated_at) }
      end
    end

    context 'Post not updated' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: post.id, post: { title: '' } })
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

    context  'update post without token' do
      before do
        put(:update, format: :json, params: { id: post.id, post: { title: 'New testing name' } })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
