class Reservation < ApplicationRecord
  include Eventable

  belongs_to :listing

  after_create -> { CreateCheckoutCheckinMissionJob.perform_now(self) }
  after_destroy -> { DestroyCheckoutCheckinMissionJob.perform_now(self) }

  def self.import(reservation_attributes)
    reservation_attributes.each do |attributes|
      Reservation.create(attributes)
    end
  end
end
