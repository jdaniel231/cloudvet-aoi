class Api::V1::ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :update, :destroy]

  def index
    pagy, clients = pagy(Client.includes(:animals).all)
    render json: {
      clients: clients.as_json(include: { animals: { only: [:name, :species] } }),
      pagy: pagy_metadata(pagy)
    }
  end




  def show
    @client = Client.find(params[:id])
    render json: @client, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Client not found' }, status: :not_found
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id
    if @client.save
      render json: @client, status: :created
    else
      render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      render json: @client, status: :ok
    else
      render json: { errors: @client.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Client not found' }, status: :not_found
  end

  private

  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Client not found' }, status: :not_found
  end

  def client_params
    params.require(:client).permit(:name, :cpf, :rg, :address, :address_number, :address_compl, :address_neighborhood)
  end
end
