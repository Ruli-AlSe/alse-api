require 'rails_helper'

describe 'Post routes' do
  it 'create post route' do
    expect(post: 'v1/posts').to route_to(
      format: :json,
      controller: 'v1/posts',
      action: 'create'
    )
  end

  it 'update post route' do
    expect(put: 'v1/posts/1').to route_to(
      format: :json,
      controller: 'v1/posts',
      action: 'update',
      id: '1'
    )
  end

  it 'index post route' do
    expect(get: 'v1/posts').to route_to(
      format: :json,
      controller: 'v1/posts',
      action: 'index'
    )
  end

  it 'delete post route' do
    expect(delete: 'v1/posts/1').to route_to(
      format: :json,
      controller: 'v1/posts',
      action: 'destroy',
      id: '1'
    )
  end

  it 'restore post route' do
    expect(post: 'v1/posts/1/restore').to route_to(
      format: :json,
      controller: 'v1/posts',
      action: 'restore',
      post_id: '1'
    )
  end
end
