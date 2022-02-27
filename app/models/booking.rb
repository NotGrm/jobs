class Booking < ApplicationRecord
  belongs_to :listing

  after_create -> { CreateFirstCheckinMissionJob.perform_now(self) }
  after_create -> { CreateLastCheckoutMissionJob.perform_now(self) }

  before_destroy :prevent_destroy_if_started

  after_destroy -> { DestroyFirstCheckinMissionJob.perform_now(self) }
  after_destroy -> { DestroyLastCheckoutMissionJob.perform_now(self) }
  after_destroy -> { DestroyAllBookedReservationJob.perform_now(self) }

  def self.import(booking_attributes)
    booking_attributes.each do |attributes|
      Booking.create(attributes)
    end
  end

  private

  def prevent_destroy_if_started
    return if start_date > Date.current

    errors.add(:start_date, 'reservation is started')
    throw :abort
  end
end
