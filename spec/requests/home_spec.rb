require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /greetings" do
    it "returns http success" do
      get "/home/greetings"
      expect(response).to have_http_status(:success)
    end
  end

end
