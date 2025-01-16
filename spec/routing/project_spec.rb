require 'rails_helper'

describe 'Project routes' do
  it 'show projects route' do
    expect(get: 'v1/projects').to route_to(
      format: :json,
      controller: 'v1/projects',
      action: 'index'
    )
  end

  it 'create project route' do
    expect(post: 'v1/projects').to route_to(
      format: :json,
      controller: 'v1/projects',
      action: 'create'
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

  it 'delete project route' do
    expect(delete: 'v1/projects/1').to route_to(
      format: :json,
      controller: 'v1/projects',
      action: 'destroy',
      id: '1'
    )
  end
end
