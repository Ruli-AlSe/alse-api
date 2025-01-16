module V1
  class EducationsController < ApplicationController
    before_action :authenticate_user
    before_action :set_profile
    before_action :set_education, only: %i[update destroy]

    def create
      @education = @profile.educations.new(education_params)
      if @education.valid?
        @education.save
        render :show, status: :created
      else
        render json: { errors: @education.errors.full_messages }, status: :bad_request
      end
    end

    def update
      if @education.update(education_params)
        render :show, status: :ok
      else
        render json: { errors: @education.errors.full_messages }, status: :bad_request
      end
    end

    def destroy
      @education.destroy
      head :ok
    end

    private

    def set_profile
      @profile = @current_user.profile
    end

    def education_params
      params.require(:education)
            .permit(:school_name, :career, :start_date, :end_date, :location, :professional_license, :is_course,
                    relevant_topics: [])
    end

    def set_education
      @education = @profile.educations.find_by(id: params[:id])

      head :not_found unless @education
    end
  end
end
