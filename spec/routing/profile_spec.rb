require 'rails_helper'

describe 'Profile routes' do
  it 'show profile route' do
    expect(get: 'v1/profiles/user@email.com').to route_to(
      format: :json,
      controller: 'v1/profiles',
      action: 'show',
      email: 'user@email.com'
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

  it 'create Skill in Profile route' do
    expect(post: 'v1/profiles/1/skills').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'create',
      profile_id: '1'
    )
  end

  it 'update Skill in Profile route' do
    expect(put: 'v1/profiles/1/skills/2').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'update',
      profile_id: '1',
      id: '2'
    )
  end

  it 'delete Skill in Profile route' do
    expect(delete: 'v1/profiles/1/skills/2').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'destroy',
      profile_id: '1',
      id: '2'
    )
  end
end
