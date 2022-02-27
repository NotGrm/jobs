class DestroyCheckoutCheckinMissionJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    planned_checkout_checkin = Mission.checkout_checkin.find_by(
      date: reservation.end_date,
      listing_id: reservation.listing_id
    )

    return unless planned_checkout_checkin

    planned_checkout_checkin.destroy
  end
end
