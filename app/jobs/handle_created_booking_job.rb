class HandleCreatedBookingJob < ApplicationJob
  queue_as :default

  def perform(booking)
    Bookings::CreateFirstCheckinMissionJob.perform_now(booking)
    Bookings::CreateLastCheckoutMissionJob.perform_now(booking)
  end
end
