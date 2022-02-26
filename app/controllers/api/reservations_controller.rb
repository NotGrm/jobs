module API
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: %i[ show update destroy ]

    # GET /api/reservations
    def index
      @reservations = Reservation.all
    end

    # GET /api/reservations/1
    def show
    end

    # POST /api/reservations
    def create
      @reservation = Reservation.new(reservation_params)

      if @reservation.save
        render :show, status: :created, location: @reservation
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/reservations/1
    def update
      if @reservation.update(reservation_params)
        render :show, status: :ok, location: @reservation
      else
        render json: @reservation.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/reservations/1
    def destroy
      @reservation.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def reservation_params
        params.require(:reservation).permit(:listing_id, :start_date, :end_date)
      end
  end
end
