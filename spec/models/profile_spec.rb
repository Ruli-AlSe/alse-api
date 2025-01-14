require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Validations - ' do
    it 'validate if there is a relation with user' do
      should belong_to(:profilable)
    end
  end
end
