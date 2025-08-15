class Api::V1::VaccineTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vaccine_type, only: [:show, :update, :destroy]

  def index
    @pagy, @vaccine_types = pagy(VaccineType.all)
    render json: @vaccine_types, meta: pagy_metadata(@pagy)
  end

  def show
    render json: @vaccine_type, serializer: VaccineTypeSerializer, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Vaccine type not found' }, status: :not_found
  end

  def create  
    @vaccine_type = VaccineType.new(vaccine_type_params)
    if @vaccine_type.save
      render json: @vaccine_type, status: :created
    else
      render json: { errors: @vaccine_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @vaccine_type.update(vaccine_type_params)
      render json: @vaccine_type, status: :ok
    else
      render json: { errors: @vaccine_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @vaccine_type.destroy
    head :no_content
  end

  private

  def set_vaccine_type
    @vaccine_type = VaccineType.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Vaccine type not found' }, status: :not_found
  end

  def vaccine_type_params
    params.require(:vaccine_type).permit(:name)
  end
end
