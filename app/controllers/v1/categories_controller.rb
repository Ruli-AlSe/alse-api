module V1
  class CategoriesController < ApplicationController
    before_action :authenticate_user, only: %i[create update destroy]
    before_action :set_company_by_current_user, only: %i[create update destroy]
    before_action :set_company_by_email, only: %i[index]
    before_action :set_categories, only: %i[update destroy]

    def index
      @categories = @company.categories
    end

    def create
      @category = @company.categories.new(category_params)

      if @category.valid?
        @category.save
        render :show, status: :created
      else
        render json: { errors: @category.errors.messages }, status: :bad_request
      end
    end

    def update
      if @category.update(category_params)
        render :show, status: :ok
      else
        render json: { errors: @category.errors.messages }, status: :bad_request
      end
    end

    def destroy
      @category.destroy
      head :ok
    end

    private

    def category_params
      params.require(:category).permit(:title, :description, :slug)
    end

    def set_company
      @company = @current_user.company
    end

    def set_company_by_email
      user = User.find_by(email: params[:email]) if params[:email].present?
      @company = user&.company

      head :not_found unless @company
    end

    def set_company_by_current_user
      @company = @current_user.company
    end

    def set_categories
      @category = @company.categories.find_by(id: params[:id])

      head :not_found unless @category
    end
  end
end
