module Api
  module V1
    class ClinicServicesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_clinic_service, only: %i[show update destroy]

      def index
        @pagy, @clinic_services = pagy(ClinicService.all)
        render json: @clinic_services, meta: pagy_metadata(@pagy)
      end

      def show
        render json: @clinic_service, serializer: ClinicServiceSerializer, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Clinic service not found' }, status: :not_found
      end

      def create
        @clinic_service = ClinicService.new(clinic_service_params)
        if @clinic_service.save
          render json: @clinic_service, status: :created
        else
          render json: { errors: @clinic_service.errors.full_messages }, status: :unprocessable_content
        end
      end

      def update
        if @clinic_service.update(clinic_service_params)
          render json: @clinic_service, status: :ok
        else
          render json: { errors: @clinic_service.errors.full_messages }, status: :unprocessable_content
        end
      end

      def destroy
        @clinic_service.destroy
        head :no_content
      end

      private

      def set_clinic_service
        @clinic_service = ClinicService.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Clinic service not found' }, status: :not_found
      end

      def clinic_service_params
        params.require(:clinic_service).permit(:name, :cost_value, :total_value)
      end
    end
  end
end
