module V1
  class CompaniesController < ApplicationController
    before_action :authenticate_user
    before_action :set_company

    def show
    end

    private

    def set_company
      if @current_user.company.id.to_s == params[:id]
        @company = @current_user.company
      else
        head :unauthorized
      end
    end
  end
end
