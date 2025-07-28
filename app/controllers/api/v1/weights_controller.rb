class Api::V1::WeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_animal, only: [:index, :create, :destroy]
  before_action :set_weight, only: [:destroy]

  # GET /api/v1/clients/:client_id/animals/:animal_id/weights
  def index
    @weights = @animal.weights.order(created_at: :desc).includes(:user)
    render json: @weights.as_json(include: { user: { only: [:id, :email] } }), status: :ok
  end

  # POST /api/v1/clients/:client_id/animals/:animal_id/weights
  def create
    @weight = Weight.new(weight_params.merge(
      user: current_user,
      animal: @animal
    ))
    if @weight.save
      render json: @weight, status: :created
    else
      render json: { errors: @weight.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/clients/:client_id/animals/:animal_id/weights/:id
  def destroy
    @weight.destroy
    render json: { message: 'Weight successfully deleted' }, status: :ok
  end

  private

  def set_animal
    @client = Client.find(params[:client_id])
    @animal = Animal.find_by(id: params[:animal_id], client_id: @client.id)
    unless @animal
      render json: { error: 'Animal not found' }, status: :not_found
    end
  end

  def set_weight
    @weight = @animal.weights.find_by(id: params[:id])
    if @weight.nil?
      render json: { error: 'Weight not found' }, status: :not_found
    end
  end

  def weight_params
    params.require(:weight).permit(:kg)
  end
end
