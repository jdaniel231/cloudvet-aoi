module Api
  module V1
    class TicketsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_ticket, only: %i[show update destroy]

      def index
        @tickets = if params[:animal_id]
                     Ticket.where(animal_id: params[:animal_id]).includes(:user, :animal, :ticket_items)
                   else
                     Ticket.includes(:user, :animal, :ticket_items).all
                   end
        render json: @tickets, each_serializer: TicketSerializer, status: :ok
      end

      def show
        render json: @ticket, serializer: TicketSerializer, status: :ok
      end

      def create
        @ticket = Ticket.new(ticket_params)
        @ticket.animal_id ||= params[:animal_id] # Captura da URL se não estiver no body
        @ticket.user_id = current_user.id

        if @ticket.save
          @ticket.recalculate_totals!
          render json: @ticket, status: :created
        else
          render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_content
        end
      end

      def update
        if @ticket.update(ticket_params)
          @ticket.recalculate_totals!
          render json: @ticket, status: :ok
        else
          render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_content
        end
      end

      def destroy
        @ticket.destroy
        head :no_content
      end

      private

      def set_ticket
        @ticket = Ticket.find(params[:id])
      end

      def ticket_params
        params.require(:ticket).permit(
          :animal_id, :payment_status, :discount, :surcharge, :payment_method, :payment_date,
          ticket_items_attributes: %i[id item_type reference_id description quantity unit_price discount _destroy]
        )
      end
    end
  end
end
