# app/controllers/api/v1/animals_controller.rb
module Api
  module V1
    class AnimalsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_animal, only: [:show, :update, :destroy]

      def index
        if params[:client_id]
          @animals = Animal.where(client_id: params[:client_id])
        else
          @animals = Animal.all
        end
        render json: @animals
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
          render json: @animal
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
        @animal = Animal.find_by(id: params[:id])
      end

      def animal_params
        params.require(:animal).permit(:name, :species, :age, :sex)
      end
    end
  end
end
