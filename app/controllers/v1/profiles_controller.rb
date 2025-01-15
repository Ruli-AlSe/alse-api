module V1
  class ProfilesController < ApplicationController
    before_action :authenticate_user
    before_action :set_profile

    def show
    end

    def update
      if !profile_params.empty? && @profile.update(profile_params)
        render :show, status: :ok
      else
        render json: { errors: @profile.errors.messages }, status: :bad_request
      end
    end

    private

    def set_profile
      if @current_user.profile && @current_user.profile.id.to_s == params[:id]
        @profile = @current_user.profile
      else
        head :unauthorized
      end
    end

    def profile_params
      params.require(:profile)
            .permit(:name, :last_name, :headliner, :bio, :city, :state, :country, :phone_number, :social_media,
                    skills_attributes: [:name, :icon_url, :level, :category_id])
    end
  end
end
