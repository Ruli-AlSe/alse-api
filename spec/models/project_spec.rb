require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Validations of the model' do
    it 'name is present' do
      should validate_presence_of(:name)
    end

    it 'description is present' do
      should validate_presence_of(:description)
    end

    it 'live_url is present' do
      should validate_presence_of(:live_url)
    end

    it 'repository_url is present' do
      should validate_presence_of(:repository_url)
    end

    it 'belogs to a company' do
      should belong_to(:company)
    end
  end
end
