require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations of user model' do
    subject { build(:owner) }

    it 'validate if email is present' do
      should validate_presence_of(:email)
    end

    it 'validate if password is present' do
      should validate_presence_of(:password_digest)
    end

    it 'validate if type is present' do
      should validate_presence_of(:type)
    end

    it 'validate if age is present' do
      should validate_presence_of(:age)
    end

    it 'validate if email is unique' do
      should validate_uniqueness_of(:email)
    end

    it 'validate reject wrong emails' do
      should_not allow_value('test').for(:email)
    end

    it 'validate age is an integer' do
      should validate_numericality_of(:age).only_integer
    end

    it 'validate age is greater than or equal to 18' do
      should validate_numericality_of(:age).is_greater_than_or_equal_to(18)
    end

    it 'validate age is lower than or equal to 100' do
      should validate_numericality_of(:age).is_less_than_or_equal_to(100)
    end

    it 'validate we can only create employee or owner' do
      should validate_inclusion_of(:type).in_array(%w[Owner Employee])
    end

    it 'validate if exists relation with company' do
      should belong_to(:company)
    end

    it 'validate relation with tokens' do
      should have_many(:tokens)
    end
  end
end
