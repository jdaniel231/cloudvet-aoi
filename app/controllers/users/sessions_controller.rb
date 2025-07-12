class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: { message: "Login com sucesso: #{current_user.email}" }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: "Logout com sucesso" }, status: :ok
  end
end
