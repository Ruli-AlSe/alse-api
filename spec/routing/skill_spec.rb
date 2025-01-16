require 'rails_helper'

describe 'Skill routes' do
  it 'create skill route' do
    expect(post: 'v1/skills').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'create'
    )
  end

  it 'update skill route' do
    expect(put: 'v1/skills/1').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'update',
      id: '1'
    )
  end

  it 'destroy skill route' do
    expect(delete: 'v1/skills/1').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'destroy',
      id: '1'
    )
  end
end
