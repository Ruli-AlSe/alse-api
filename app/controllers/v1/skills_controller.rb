module V1
  class SkillsController < ApplicationController
    before_action :authenticate_user
    before_action :set_profile, only: %i[create]
    before_action :set_skill, only: %i[update destroy]

    def create
      @skill = @profile.skills.new(skill_params)
      if @skill.valid?
        @skill.save
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

    def set_profile
      @profile = @current_user.profile
    end

    def set_skill
      @skill = @current_user.profile.skills.find_by(id: params[:id])

      head :not_found unless @skill
    end

    def skill_params
      params.require(:skill).permit(:name, :icon_url, :category_id, :level)
    end
  end
end
