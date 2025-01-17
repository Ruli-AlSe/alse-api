module V1
  class ProfilesController < ApplicationController
    before_action :authenticate_user, only: %i[update]
    before_action :find_current_user_profile, only: %i[update]
    before_action :find_profile_by_email, only: %i[show]

    def show
    end

    def update
      if !profile_params.empty? && @profile.update(profile_params)
        render :show, status: :ok
      else
        render json: { errors: @profile.errors.full_messages }, status: :bad_request
      end
    end

    private

    def find_current_user_profile
      return nil unless params[:id].present?

      if @current_user.profile && @current_user.profile.id.to_s == params[:id]
        @profile = @current_user.profile
      else
        head :unauthorized
      end
    end

    def find_profile_by_email
      user = User.find_by(email: params[:email]) if params[:email].present?
      @profile = user&.profile

      render json: { errors: { profile: 'Not found' } }, status: :not_found unless @profile
    end

    def profile_params
      params.require(:profile)
            .permit(:name, :last_name, :headliner, :bio, :city, :state, :country, :phone_number, :social_media)
    end
  end
end
