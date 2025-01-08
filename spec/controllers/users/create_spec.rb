require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'Users register' do
    let(:user) {
      { email: Faker::Internet.email,
        age: rand(30..100),
        password: Faker::Internet.password(min_length: 10, max_length: 20),
       store_attributes: { name: Faker::Games::Zelda.game } }
    }

    context 'user registered successfully' do
      before do
        post(:create, format: :json, params: { user: user })
      end

      context 'response with status created' do
        subject { response }

        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct user data' do
        subject { payload_test }

        it { is_expected.to include(:id, :email, :age, :store) }
      end

      context 'response with correct store data' do
        subject { payload_test[:store] }
        
        it { is_expected.to include(:id, :name, :created_at, :updated_at) }
      end
    end

    let(:bad_user) { { email: "test", password: '123', age: 21 } }
    context 'user not registered' do
      before do
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
