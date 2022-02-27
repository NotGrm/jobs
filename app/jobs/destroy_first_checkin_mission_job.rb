class DestroyFirstCheckinMissionJob < ApplicationJob
  queue_as :default

  def perform(booking)
    planned_first_checkin = Mission.first_checkin.find_by(
      date: booking.start_date,
      listing_id: booking.listing_id
    )

    return unless planned_first_checkin

    planned_first_checkin.destroy
  end
end
