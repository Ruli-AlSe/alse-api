require 'rails_helper'

describe 'Job routes' do
  it 'create Job route' do
    expect(post: 'v1/jobs').to route_to(
      format: :json,
      controller: 'v1/jobs',
      action: 'create'
    )
  end

  it 'create Skill in Job route' do
    expect(post: 'v1/jobs/1/skills').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'create',
      job_id: '1'
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

  it 'update Skill in Job route' do
    expect(put: 'v1/jobs/1/skills/2').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'update',
      job_id: '1',
      id: '2'
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

  it 'destroy Skill in Job route' do
    expect(delete: 'v1/jobs/4/skills/2').to route_to(
      format: :json,
      controller: 'v1/skills',
      action: 'destroy',
      job_id: '4',
      id: '2'
    )
  end
end
