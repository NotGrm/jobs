class CreateCheckoutCheckinMissionJob < ApplicationJob
  queue_as :default

  before_perform do |job|
    reservation = job.arguments.first

    throw :abort if last_checkout_planned?(reservation)
  end

  def perform(reservation)
    Mission.create_checkout_checkin_for(reservation)
  end

  private

  def last_checkout_planned?(reservation)
    Mission.last_checkout.where(
      date: reservation.end_date,
      listing_id: reservation.listing_id
    ).exists?
  end
end
