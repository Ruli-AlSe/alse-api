require 'rails_helper'

describe 'Profile routes' do
  it 'show profile route' do
    expect(get: 'v1/profiles/1').to route_to(
      format: :json,
      controller: 'v1/profiles',
      action: 'show',
      id: '1'
    )
  end

  it 'update profile route' do
    expect(put: 'v1/profiles/1').to route_to(
      format: :json,
      controller: 'v1/profiles',
      action: 'update',
      id: '1'
    )
  end
end
