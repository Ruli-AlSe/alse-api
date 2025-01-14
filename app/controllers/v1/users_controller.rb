module V1
  class UsersController < ApplicationController
    before_action :authenticate_user, only: %i[create]

    def create
      if @current_user.admin?
        create_owner
      else
        head :unauthorized
      end
    end

    def login
      @user = User.find_by(email: login_params[:email])

      if @user.present? && @user.authenticate(login_params[:password])
        @token = @user.tokens.create
        render :show, status: :ok
      else
        render(json: { errors: I18n.t('user.bad_credentials') }, status: :bad_request)
      end
    end

    private

    def create_owner
      @user = Owner.new(user_params)

      if @user.valid?
        @user.save
        @token = @user.tokens.create
        # render json: @user, status: :created
        render :show, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :bad_request
      end
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end

    def user_params
      params.require(:user).permit(:email, :age, :password, company_attributes: %i[name])
    end
  end
end
