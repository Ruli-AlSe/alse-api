require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'Validation of the model' do
    subject { build(:skill) }

    it 'name is present' do
      should validate_presence_of(:name)
    end

    it 'belongs to category relationship' do
      should belong_to(:category)
    end

    it 'there is a relation with profile' do
      should belong_to(:skillable)
    end
  end
end
