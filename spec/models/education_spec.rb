require 'rails_helper'

RSpec.describe Education, type: :model do
  describe 'Validation of the model' do
    subject { build(:education) }

    it 'school_name is present' do
      should validate_presence_of(:school_name)
    end

    it 'career is present' do
      should validate_presence_of(:career)
    end

    it 'is_course is present' do
      should validate_presence_of(:is_course)
    end

    it 'relevant_topics is present' do
      should validate_presence_of(:relevant_topics)
    end

    it 'belongs to profile relationship' do
      should belong_to(:profile)
    end
  end
end
