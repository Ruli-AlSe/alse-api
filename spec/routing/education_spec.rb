require 'rails_helper'

describe 'Education routes' do
  it 'create education route' do
    expect(post: 'v1/educations').to route_to(
      format: :json,
      controller: 'v1/educations',
      action: 'create'
    )
  end

  it 'update education route' do
    expect(put: 'v1/educations/1').to route_to(
      format: :json,
      controller: 'v1/educations',
      action: 'update',
      id: '1'
    )
  end

  it 'destroy education route' do
    expect(delete: 'v1/educations/1').to route_to(
      format: :json,
      controller: 'v1/educations',
      action: 'destroy',
      id: '1'
    )
  end
end
