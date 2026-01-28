module Api
  module V1
    class TicketItemsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_ticket
      before_action :set_ticket_item, only: %i[show update destroy]

      def index
        @ticket_items = @ticket.ticket_items
        render json: @ticket_items, each_serializer: TicketItemSerializer, status: :ok
      end

      def show
        render json: @ticket_item, serializer: TicketItemSerializer, status: :ok
      end

      def create
        @ticket_item = @ticket.ticket_items.new(ticket_item_params)

        if @ticket_item.save
          @ticket.recalculate_totals!
          render json: @ticket_item, status: :created
        else
          render json: { errors: @ticket_item.errors.full_messages }, status: :unprocessable_content
        end
      end

      def update
        if @ticket_item.update(ticket_item_params)
          @ticket.recalculate_totals!
          render json: @ticket_item, status: :ok
        else
          render json: { errors: @ticket_item.errors.full_messages }, status: :unprocessable_content
        end
      end

      def destroy
        @ticket_item.destroy
        @ticket.recalculate_totals!
        head :no_content
      end

      private

      def set_ticket
        @ticket = Ticket.find(params[:ticket_id])
      end

      def set_ticket_item
        @ticket_item = @ticket.ticket_items.find(params[:id])
      end

      def ticket_item_params
        params.require(:ticket_item).permit(:item_type, :reference_id, :description, :quantity, :unit_price,
                                            :total_price)
      end
    end
  end
end
