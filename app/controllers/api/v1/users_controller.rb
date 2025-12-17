module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def index
        @pagy, @users = pagy(User.all)
        render json: @users, meta: pagy_metadata(@pagy)
      end
    end
  end
end
