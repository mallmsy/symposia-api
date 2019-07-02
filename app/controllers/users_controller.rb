class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :index]

    def profile
      render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def index
      @users = User.all
      render json: @users
    end

    def create
      @user = User.create(user_params)
      if @user.valid?
        @token = encode_token(user_id: @user.id)
        render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :not_acceptable
      end
    end

    def update
      @user = find_user
      @user.update(user_params)
      if @user.save
        render json: @user, status: :accepted
      else
        render json: { errors: @user.erros.full_messages }, status: :unprocessible_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :password, :bio, :slant, :img_url)
    end

    def find_user
      @user = User.find(params[:id])
    end
  end
