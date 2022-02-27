class DestroyAllBookedReservationJob < ApplicationJob
  queue_as :default

  def perform(booking)
    Reservation.where(
      start_date: booking.start_date..,
      end_date: ..booking.end_date,
      listing_id: booking.listing_id
    ).destroy_all
  end
end
