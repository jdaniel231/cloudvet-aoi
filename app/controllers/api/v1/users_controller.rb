class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @users = pagy(User.all)
    render json: @users, meta: pagy_metadata(@pagy)
  end
end