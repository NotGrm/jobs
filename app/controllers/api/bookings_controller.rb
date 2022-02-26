module API
  class BookingsController < ApplicationController
    before_action :set_booking, only: %i[ show update destroy ]

    # GET /api/bookings
    def index
      @bookings = Booking.all
    end

    # GET /api/bookings/1
    def show
    end

    # POST /api/bookings
    def create
      @booking = Booking.new(booking_params)

      if @booking.save
        render :show, status: :created, location: @booking
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/bookings/1
    def update
      if @booking.update(booking_params)
        render :show, status: :ok, location: @booking
      else
        render json: @booking.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/bookings/1
    def destroy
      @booking.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_booking
        @booking = Booking.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def booking_params
        params.require(:booking).permit(:listing_id, :start_date, :end_date)
      end
  end
end
