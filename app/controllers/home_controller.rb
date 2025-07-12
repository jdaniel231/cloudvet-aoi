class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { message: "Uhull, você está logado como #{current_user.email}!" }
  end
end
