module Api
  module V1
    class WeightsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_animal, only: %i[index create]
      before_action :set_weight, only: [:destroy]

      # GET /api/v1/clients/:client_id/animals/:animal_id/weights
      def index
        @weights = @animal.weights.order(created_at: :desc).includes(:user)
        render json: @weights.as_json(include: { user: { only: %i[id email] } }), status: :ok
      end

      # POST /api/v1/clients/:client_id/animals/:animal_id/weights
      def create
        @weight = Weight.new(weight_params.merge(
                               user: current_user,
                               animal: @animal
                             ))
        if @weight.save
          render json: @weight, serializer: WeightSerializer, status: :created
        else
          render json: { errors: @weight.errors.full_messages }, status: :unprocessable_content
        end
      end

      # DELETE /api/v1/clients/:client_id/animals/:animal_id/weights/:id
      def destroy
        @weight.destroy
        render json: { message: 'Weight successfully deleted' }, status: :ok
      end

      private

      def set_animal
        @animal = Animal.find(params[:animal_id])
      end

      def set_weight
        @weight = Weight.find(params[:id])
      end

      def weight_params
        params.require(:weight).permit(:kg)
      end
    end
  end
end
