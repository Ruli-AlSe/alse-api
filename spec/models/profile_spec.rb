require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Validations of the model' do
    it 'there is a relation with user' do
      should belong_to(:profilable)
    end

    it 'has many skills relationship' do
      should have_many(:skills)
    end

    it 'has many educations relationship' do
      should have_many(:educations)
    end

    it 'has many jobs relationship' do
      should have_many(:jobs)
    end
  end
end
