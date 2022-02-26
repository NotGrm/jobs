class Booking < ApplicationRecord
  belongs_to :listing

  def self.import(booking_attributes)
    Booking.insert_all booking_attributes
  end
end
