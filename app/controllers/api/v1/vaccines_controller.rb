# app/controllers/api/v1/vaccines_controller.rb
module Api
  module V1
    class VaccinesController < ApplicationController
      before_action :set_client
      before_action :set_animal
      before_action :set_vaccine, only: [:show, :update, :destroy]

      # GET /api/v1/clients/:client_id/animals/:animal_id/vaccines
      def index
        @vaccines = @animal.vaccines
        render json: @vaccines
      end

      # GET /api/v1/clients/:client_id/animals/:animal_id/vaccines/:id
      def show
        render json: @vaccine
      end

      # POST /api/v1/clients/:client_id/animals/:animal_id/vaccines
      def create
        if vaccine_params[:vaccine_type_id].is_a?(Array)
          created_vaccines = []
          errors = []

          Vaccine.transaction do
            vaccine_params[:vaccine_type_id].each do |type_id|
              vaccine = @animal.vaccines.build(
                vaccine_params.except(:vaccine_type_id).merge(vaccine_type_id: type_id)
              )
              if vaccine.save
                created_vaccines << vaccine
              else
                errors << vaccine.errors
                raise ActiveRecord::Rollback
              end
            end
          end

          if errors.empty?
            render json: created_vaccines, status: :created
          else
            render json: errors, status: :unprocessable_entity
          end
        else
          @vaccine = @animal.vaccines.build(vaccine_params)

          if @vaccine.save
            render json: @vaccine, status: :created
          else
            render json: @vaccine.errors, status: :unprocessable_entity
          end
        end
      end

      # PATCH/PUT /api/v1/clients/:client_id/animals/:animal_id/vaccines/:id
      def update
        if @vaccine.update(vaccine_params)
          render json: @vaccine
        else
          render json: @vaccine.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/clients/:client_id/animals/:animal_id/vaccines/:id
      def destroy
        @vaccine.destroy
        head :no_content
      end

      private

      def set_client
        @client = Client.find(params[:client_id])
      end

      def set_animal
        @animal = @client.animals.find(params[:animal_id])
      end

      def set_vaccine
        @vaccine = @animal.vaccines.find(params[:id])
      end

      def vaccine_params
        params.require(:vaccine).permit( :user_id, :application_date, :return_date, :applied_dose, :obs, vaccine_type_id: [])
      end
    end
  end
end
