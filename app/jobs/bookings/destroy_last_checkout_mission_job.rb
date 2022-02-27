module Bookings
  class DestroyLastCheckoutMissionJob < ApplicationJob
    queue_as :default

    def perform(booking)
      planned_last_checkout = Mission.last_checkout.find_by(
        date: booking.end_date,
        listing_id: booking.listing_id
      )

      return unless planned_last_checkout

      planned_last_checkout.destroy
    end
  end
end
