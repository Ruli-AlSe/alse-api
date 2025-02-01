require 'rails_helper'

RSpec.describe V1::PostsController, type: :controller do
  describe 'Create post' do
    let(:user) { create(:owner) }
    let(:category) { create(:category) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:post_info) {
      { title: Faker::Book.title,
        content: Faker::Lorem.sentence(word_count: 50),
        image_url: 'image.url',
        slug: Faker::Book.title.parameterize,
        credits: '(page.link.com, page name, user name)',
        short_description: 'this is my short description',
        category_id: category.id  }
    }

    context 'Post registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { post: post_info })
      end

      context 'response with status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct post structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :title, :content, :credits, :image_url, :slug, :short_description, :category_name,
                                 :created_at, :updated_at)
        }
      end
    end

    context 'Post not registered' do
      before do
        post_info[:title] = ''
        request.headers.merge!(headers)
        post(:create, format: :json, params: { post: post_info })
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

    context 'register post without token' do
      before do
        post(:create, format: :json, params: { post: post_info })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
