# app/controllers/api/v1/animals_controller.rb
module Api
  module V1
    class AnimalsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_animal, only: [:show, :update, :destroy]

      def index
        @pagy, @animals = pagy(Animal.by_client(params[:client_id]))
        render json: @animals, each_serializer: AnimalSerializer, meta: pagy_metadata(@pagy)
      end

      def show
        render json: @animal
      end

      def create
        if params[:client_id]
          client = Client.find_by(id: params[:client_id])
          return render json: { error: 'Client not found' }, status: :not_found unless client

          @animal = client.animals.build(animal_params)
        else
          @animal = Animal.new(animal_params)
        end

        if @animal.save
          render json: @animal, status: :created
        else
          render json: @animal.errors, status: :unprocessable_entity
        end
      end

      def update
        if @animal.update(animal_params)
          render json: @animal, serializer: AnimalSerializer
        else
          render json: @animal.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @animal.destroy
        head :no_content
      end

      private

      def set_animal
        @animal = Animal.find(params[:id])
      end

      def animal_params
        params.require(:animal).permit(:name, :species, :age, :sex)
      end
    end
  end
end
