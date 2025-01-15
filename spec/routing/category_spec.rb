require 'rails_helper'

describe 'Category routes' do
  it 'index category route' do
    expect(get: 'v1/categories').to route_to(
      format: :json,
      controller: 'v1/categories',
      action: 'index'
    )
  end

  it 'create category route' do
    expect(post: 'v1/categories').to route_to(
      format: :json,
      controller: 'v1/categories',
      action: 'create'
    )
  end

  it 'update category route' do
    expect(put: 'v1/categories/1').to route_to(
      format: :json,
      controller: 'v1/categories',
      action: 'update',
      id: '1'
    )
  end

  it 'destroy category route' do
    expect(delete: 'v1/categories/1').to route_to(
      format: :json,
      controller: 'v1/categories',
      action: 'destroy',
      id: '1'
    )
  end
end
