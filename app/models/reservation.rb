class Reservation < ApplicationRecord
  belongs_to :listing

  after_create -> { CreateCheckoutCheckinMissionJob.perform_now(self) }

  before_destroy :prevent_destroy_if_started

  after_destroy -> { DestroyCheckoutCheckinMissionJob.perform_now(self) }

  def self.import(reservation_attributes)
    reservation_attributes.each do |attributes|
      Reservation.create(attributes)
    end
  end

  private

  def prevent_destroy_if_started
    return if start_date > Date.current

    errors.add(:start_date, 'reservation is started')
    throw :abort
  end
end
