require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'Validation of the model' do
    subject { build(:job) }

    it 'title is present' do
      should validate_presence_of(:title)
    end

    it 'location is present' do
      should validate_presence_of(:location)
    end

    it 'job_type is present' do
      should validate_presence_of(:job_type)
    end

    it 'company_name is present' do
      should validate_presence_of(:company_name)
    end

    it 'activities is present' do
      should validate_presence_of(:activities)
    end

    it 'belongs to profile relationship' do
      should belong_to(:profile)
    end
  end
end
