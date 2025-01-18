require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do
  describe 'Projects listing' do
    let(:user) { create(:owner) }
    let(:projects) { create_list(:project, 5, company: user.company) }

    context 'get all projects correctly' do
      before do
        get(:index, format: :json, params: { email: user.email })
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'correct structure of response' do
        subject { payload_test }
        it 'includes a projects key' do
          expect(subject).to include(:projects)
        end

        it 'ensures projects is an array' do
          expect(subject[:projects]).to be_an(Array)
        end

        it 'ensures all elements in projects have correct company_id' do
          expect(subject[:projects]).to all(include(company_id: user.company_id))
        end
      end
    end

    context 'get projects with incorrect email' do
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
