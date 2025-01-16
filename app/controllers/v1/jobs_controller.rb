module V1
  class JobsController < ApplicationController
    before_action :authenticate_user
    before_action :set_profile
    before_action :set_job, only: %i[update destroy]

    def create
      @job = @profile.jobs.new(job_params)
      if @job.valid?
        @job.save
        render :show, status: :created
      else
        render json: { errors: @job.errors.full_messages }, status: :bad_request
      end
    end

    def update
      if @job.update(job_params)
        render :show, status: :ok
      else
        render json: { errors: @job.errors.full_messages }, status: :bad_request
      end
    end

    def destroy
      @job.destroy
      head :ok
    end

    private

    def set_profile
      @profile = @current_user.profile
    end

    def job_params
      params.require(:job)
            .permit(:title, :location, :job_type, :company_name, :start_date, :end_date, activities: [])
    end

    def set_job
      @job = @profile.jobs.find_by(id: params[:id])

      head :not_found unless @job
    end
  end
end
