require 'rails_helper'

describe 'Product routes' do
  it 'create product route' do
    expect(post: 'v1/products').to route_to(
      format: :json,
      controller: 'v1/products',
      action: 'create'
    )
  end
end
