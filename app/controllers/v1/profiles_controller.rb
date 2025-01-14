module V1
  class ProfilesController < ApplicationController
    before_action :authenticate_user
    before_action :set_profile

    def show
    end

    private

    def set_profile
      if @current_user.profile && @current_user.profile.id.to_s == params[:id]
        @profile = @current_user.profile
      else
        head :unauthorized
      end
    end
  end
end
