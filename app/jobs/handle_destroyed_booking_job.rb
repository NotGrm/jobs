class HandleDestroyedBookingJob < ApplicationJob
  queue_as :default

  def perform(booking)
    Bookings::DestroyFirstCheckinMissionJob.perform_now(booking)
    Bookings::DestroyLastCheckoutMissionJob.perform_now(booking)
    Bookings::DestroyAllBookedReservationJob.perform_now(booking)
  end
end
