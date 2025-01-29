module V1
  class SkillsController < ApplicationController
    before_action :authenticate_user
    before_action :set_skillable
    before_action :set_skill, only: %i[update destroy]

    def create
      @skill = @skillable.skills.new(skill_params)
      if @skill.save
        render :show, status: :created
      else
        render json: { errors: @skill.errors.messages }, status: :bad_request
      end
    end

    def update
      if @skill.update(skill_params)
        render :show, status: :ok
      else
        render json: { errors: @skill.errors.messages }, status: :bad_request
      end
    end

    def destroy
      @skill.destroy
      head :ok
    end

    private

    def set_skillable
      if params[:profile_id]
        @skillable = Profile.find(params[:profile_id])
      elsif params[:project_id]
        @skillable = Project.find(params[:project_id])
      elsif params[:job_id]
        @skillable = Job.find(params[:job_id])
      else
        head :not_found
      end
    end

    def set_skill
      @skill = @skillable.skills.find_by(id: params[:id])
      head :not_found unless @skill
    end

    def skill_params
      params.require(:skill).permit(:name, :icon_url, :category_id, :level)
    end
  end
end