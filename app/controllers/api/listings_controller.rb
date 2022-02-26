module API
  class ListingsController < ApplicationController
    before_action :set_listing, only: %i[ show update destroy ]

    # GET /api/listings
    def index
      @listings = Listing.all
    end

    # GET /api/listings/1
    def show
    end

    # POST /api/listings
    def create
      @listing = Listing.new(listing_params)

      if @listing.save
        render :show, status: :created, location: @listing
      else
        render json: @listing.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/listings/1
    def update
      if @listing.update(listing_params)
        render :show, status: :ok, location: @listing
      else
        render json: @listing.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/listings/1
    def destroy
      @listing.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_listing
        @listing = Listing.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def listing_params
        params.require(:listing).permit(:number_of_rooms)
      end
  end
end
