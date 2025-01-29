require 'rails_helper'

describe 'Project routes' do
  it 'show projects route' do
    expect(get: 'v1/projects/user@email.com').to route_to(
      format: :json,
      controller: 'v1/projects',
      action: 'index',
      email: 'user@email.com'
    )
  end

  it 'create project route' do
    expect(post: 'v1/projects').to route_to(
      format: :json,
      controller: 'v1/projects',
      action: 'create'
    )
  end

  it 'create Skill in Project route' do
    expect(post: 'v1/projects/1/skills').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'create',
      project_id: '1'
    )
  end

  it 'update project route' do
    expect(put: 'v1/projects/1').to route_to(
      format: :json,
      controller: 'v1/projects',
      action: 'update',
      id: '1'
    )
  end

  it 'update Skill in Project route' do
    expect(put: 'v1/projects/1/skills/2').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'update',
      project_id: '1',
      id: '2'
    )
  end

  it 'delete project route' do
    expect(delete: 'v1/projects/1').to route_to(
      format: :json,
      controller: 'v1/projects',
      action: 'destroy',
      id: '1'
    )
  end

  it 'delete Skill in Project route' do
    expect(delete: 'v1/projects/1/skills/2').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'destroy',
      project_id: '1',
      id: '2'
    )
  end
end
