require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'Users sign up' do
    let(:admin_user) { create(:admin) }
    let(:bearer) { create(:token, user: admin_user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:user) {
      { email: Faker::Internet.email,
        age: rand(30..100),
        password: Faker::Internet.password(min_length: 10, max_length: 20),
        company_attributes: { name: Faker::Games::Zelda.game } }
    }

    context 'user has been registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { user: user })
      end

      context 'response with status created' do
        subject { response }

        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct user data' do
        subject { payload_test }

        it { is_expected.to include(:id, :email, :age, :company, :token) }
      end

      context 'response with correct company data' do
        subject { payload_test[:company] }

        it { is_expected.to include(:id, :name, :created_at, :updated_at) }
      end

      context 'response with correct token' do
        subject { payload_test[:token] }

        it { is_expected.to include(:id, :token, :expires_at) }
      end
    end

    let(:bad_user) { { email: "test", password: '123', age: 21 } }
    context 'user not registered' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { user: bad_user })
      end

      context 'response with status bad request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'response with validation errors' do
        subject { payload_test }
        it { is_expected.to include(:errors) }
      end
    end
  end
end
