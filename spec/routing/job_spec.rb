require 'rails_helper'

describe 'Job routes' do
  it 'create Job route' do
    expect(post: 'v1/jobs').to route_to(
      format: :json,
      controller: 'v1/jobs',
      action: 'create'
    )
  end

  it 'update job route' do
    expect(put: 'v1/jobs/1').to route_to(
      format: :json,
      controller: 'v1/jobs',
      action: 'update',
      id: '1'
    )
  end

  it 'destroy job route' do
    expect(delete: 'v1/jobs/1').to route_to(
      format: :json,
      controller: 'v1/jobs',
      action: 'destroy',
      id: '1'
    )
  end
end
