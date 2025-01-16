module V1
  class ProjectsController < ApplicationController
    before_action :authenticate_user
    before_action :set_company
    before_action :set_project, only: %i[update destroy]

    def index
      @projects = @company.projects
    end

    def create
      @project = @company.projects.new(project_params)
      if @project.valid?
        @project.save
        render :show, status: :created
      else
        render json: { errors: @project.errors.full_messages }, status: :bad_request
      end
    end

    def update
      if @project.update(project_params)
        render :show, status: :ok
      else
        render json: { errors: @project.errors.full_messages }, status: :bad_request
      end
    end

    def destroy
      @project.destroy

      head :ok
    end

    private

    def set_company
      @company = @current_user.company
    end

    def project_params
      params.require(:project)
            .permit(:name, :description, :company_name, :live_url, :repository_url)
    end

    def set_project
      @project = @company.projects.find_by(id: params[:id])

      head :not_found unless @project
    end
  end
end
