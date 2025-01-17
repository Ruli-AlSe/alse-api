module V1
  class PostsController < ApplicationController
    before_action :authenticate_user, only: %i[create update destroy restore]
    before_action :set_company_by_current_user, only: %i[create update destroy restore]
    before_action :set_company_by_email, only: %i[index]
    before_action :set_post, only: %i[update destroy]

    def index
      puts @company.inspect
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

    def set_company_by_email
      user = User.find_by(email: params[:email]) if params[:email].present?
      @company = user&.company

      head :not_found unless @company
    end

    def post_params
      params.require(:post).permit(:title, :content, :credits, :image_url, :slug, :category_id)
    end

    def set_company_by_current_user
      @company = @current_user.company
    end

    def set_post
      @post = @company.posts.find_by(id: params[:id])

      head :not_found unless @post
    end
  end
end
