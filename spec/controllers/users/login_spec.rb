require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'User login' do
    let(:user) { create(:owner, password: '12345678') }

    context 'with successful login' do
      before do
        post(:login, format: :json, params: { user: { email: user.email, password: '12345678' } })
      end

      context 'ok status' do
        subject { response }

        it { is_expected.to have_http_status(:ok) }
      end

      context 'correct login response' do
        subject { payload_test }

        it { is_expected.to include(:id, :email, :age, :company, :token) }
      end

      context 'correct structure of token response' do
        subject { payload_test[:token] }

        it { is_expected.to include(:id, :token, :expires_at) }
      end
    end

    context 'with unsuccessful login' do
      before do
        post(:login, format: :json, params: { user: { email: user.email, password: '' } })
      end

      context 'bad request status' do
        subject { response }

        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'incorrect login response' do
        subject { payload_test }

        it { is_expected.to include(:errors) }
      end
    end
  end
end
