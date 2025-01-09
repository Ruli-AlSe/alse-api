require 'rails_helper'

describe 'Product routes' do
  it 'create product route' do
    expect(post: 'v1/products').to route_to(
      format: :json,
      controller: 'v1/products',
      action: 'create'
    )
  end

  it 'update product route' do
    expect(put: 'v1/products/1').to route_to(
      format: :json,
      controller: 'v1/products',
      action: 'update',
      id: '1'
    )
  end

  it 'index product route' do
    expect(get: 'v1/products').to route_to(
      format: :json,
      controller: 'v1/products',
      action: 'index'
    )
  end
end
