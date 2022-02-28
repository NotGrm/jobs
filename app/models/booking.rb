class Booking < ApplicationRecord
  include Eventable

  belongs_to :listing

  after_create -> { HandleCreatedBookingJob.perform_now(self) }
  after_destroy -> { HandleDestroyedBookingJob.perform_now(self) }

  def self.import(booking_attributes)
    booking_attributes.each do |attributes|
      Booking.create(attributes)
    end
  end
end
