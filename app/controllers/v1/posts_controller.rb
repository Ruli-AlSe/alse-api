module V1
  class PostsController < ApplicationController
    before_action :authenticate_user
    before_action :set_company
    before_action :set_posts, only: %i[update destroy]

    def index
      @posts = @company.posts
    end

    def create
      @post = @company.posts.new(post_params)

      if @post.valid?
        @post.save
        render :show, status: :created
      else
        render json: { errors: @post.errors.messages }, status: :bad_request
      end
    end

    def update
      if @post.update(post_params)
        render :show, status: :ok
      else
        render json: { errors: @post.errors.messages }, status: :bad_request
      end
    end

    def destroy
      @post.destroy
      head :ok
    end

    def restore
      @post = @company.posts.only_deleted.find_by(id: params[:post_id])

      head :not_found unless @post
      Post.restore(@post.id)

      render :show, status: :ok
    end

    private

    def post_params
      params.require(:post).permit(:name, :description, :price)
    end

    def set_company
      @company = @current_user.company
    end

    def set_posts
      @post = @company.posts.find_by(id: params[:id])

      head :not_found unless @post
    end
  end
end
