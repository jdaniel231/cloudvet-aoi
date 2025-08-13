module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :set_client_and_animal
      before_action :set_appointment, only: [:show, :update, :destroy]

      # GET /api/v1/clients/:client_id/animals/:animal_id/appointments
      def index
        @pagy, @appointments = pagy(@animal.appointments.includes(:user))
        render json: @appointments, each_serializer: AppointmentSerializer, meta: pagy_metadata(@pagy), status: :ok
      end


      # GET /api/v1/clients/:client_id/animals/:animal_id/appointments/:id
      def show
        render json: @appointment, status: :ok
      end

      # POST /api/v1/clients/:client_id/animals/:animal_id/appointments
      def create
        @appointment = Appointment.new(appointment_params.merge(
          user: current_user,
          client: @client,
          animal: @animal
        ))

        if @appointment.save
          render json: @appointment, status: :created
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/clients/:client_id/animals/:animal_id/appointments/:id
      def update
        if @appointment.update(appointment_params)
          render json: @appointment, status: :ok
        else
          render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/clients/:client_id/animals/:animal_id/appointments/:id
      def destroy
        @appointment.destroy
        render json: { message: 'Appointment successfully deleted' }, status: :ok
      end

      private

      # Busca client e animal para todas ações (exceto talvez index se quiser listar geral)
      def set_client_and_animal
        @client = Client.find(params[:client_id])
        @animal = @client.animals.find(params[:animal_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Client or Animal not found' }, status: :not_found
      end

      # Busca a consulta garantindo que pertence ao client e animal indicados
      def set_appointment
        @appointment = @animal.appointments.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Appointment not found' }, status: :not_found
      end

      def appointment_params
        params.require(:appointment).permit(
          :chief_complaint,
          :medical_history,
          :suspected_exams
        )
      end
    end
  end
end
